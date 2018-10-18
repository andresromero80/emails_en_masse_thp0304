require 'dotenv'

Dotenv.load

require 'gmail'
require 'json'

class MailerManager

attr_accessor :gmail, :array_mails

  def initialize

  @gmail = Gmail.connect(ENV["MAILER_ID"], ENV["MAILER_PASSWORD"])  
  @array_mails = [] 

  end 

  def recuperate_mail

    datas = JSON.parse(File.read("mairie.JSON"))

    datas.each do |mails|

 
    if mails[1].include? ?@
    
    @array_mails << mails[1]

    end 
   end
  
  end


 def envoi_mail(array_mails)

    array_mails.each do |emails|
      email = @gmail.compose do
      to emails
      subject "Voulez vous changer le monde avec nous ?"
      body "

  Bonjour,
  Nous sommes élèves à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

  Déjà 500 personnes sont passées par The Hacking Project. Est-ce que votre mairie veut changer le monde avec nous ?


  Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"
    end
      
      email.deliver! 
      @gmail.logout
    
   end

  end

end







   


