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

 def envoi_mail(array_mails)
    array_mails.each do | address |
      begin
        gmail.deliver do
          to address
          subject "Voulez vous changer le monde avec nous ?"
          html_part do
            content_type 'text/html; charset=UTF-8'
            body "<p>
                    Bonjour,
                  </p>
                  
                  <p>
                    Nous sommes élèves à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique.
                    <br>
                    La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code.
                    <br>
                    Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.
                    <br>
                    Déjà 500 personnes sont passées par The Hacking Project. Est-ce que votre mairie veut changer le monde avec nous ?
                  </p>

                  <p>
                    Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80
                  </p>"
          end
        end
      rescue StandardError => e
        puts e.class
        puts e.message
      end
      puts "Email sent to : #{address}"
    end
    @gmail.logout
    sleep(2)
  end
end