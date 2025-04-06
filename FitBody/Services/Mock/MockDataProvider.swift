import Foundation
import CoreLocation

final class MockDataProvider {
    static var doctors: [Doctor] = [
        Doctor(
            id: 1,
            type: "Rehabilitologist",
            firstName: "Alexander",
            lastName: "Dorofeev",
            illustration: URL(string: "https://doq.kz/media/doctors/7988/dorofeev-aleksandr.jpeg")!,
            rating: 9.66,
            hospital: Doctor.Hospital(
                id: 1,
                name: "Expert Neuro",
                rating: 4.7,
                address: Address(
                    name: "Auezov St 67",
                    latitude: 43.2436367,
                    longitude: 76.9030064
                )
            ),
            yearsExpert: 17,
            description: """
            Опыт работы в реабилитологии и восстановительной медицине более 15 лет.\n
            Специализируюсь на заболеваниях опорно-двигательного аппарата:
            - На заболеваниях опорно-двигательного аппарата, артриты, артрозы
            - На заболевания центральной нервной системы
            - На заболеваниях межпозвоночных дисков позвоночника. Остеохондроз, Грыжа, смещение позвоночника. Боли в спине различного происхождения
            - Кинезитерпия взрослая, детская
            - Плазмолифтинг
            - Кинезитейпирование
            - Ортезирование стоп
            """,
            reviews: [
                "Замечательный, грамотный,очень внимательный врач, знающий своё дело, первая консультация и мы пока довольны, очень рекомендую, успокоил не пугал, все разъяснил. Доктор внушает доверее, что сейчас особо важно и редко.",
                "Замечательный доктор. Грамотный, профессионал своего дела. При обращении в любое время готов прийти на помощь. Очень тактичный врач. Благодарна что попала именно к нему",
                "Супер доктор, всем советую. Знаю Дорофеева Александра Александровича давно и доверяю ему.",
                "Дорофеев Александр Александрович отличный врач, спасибо ему большое, грамотный и профессиональный. Рекомендую.",
                "Приемом довольна, все отлично.",
                "Дорофеев Александр Александрович отличный доктор, я довольна приемом."
            ]
        ),
        Doctor(
            id: 2,
            type: "Rehabilitologist",
            firstName: "Kamila",
            lastName: "Ushurova",
            illustration: URL(string: "https://idoctor.kz/images/doctors/1227001/1227413/gwvhI0lfs40SUr5HzgTOMPKcJpVQk5bmh8e2EEhH_300x300.png")!,
            rating: 9.6,
            hospital: Doctor.Hospital(
                id: 2,
                name: "Atlant Clinic",
                rating: 5,
                address: Address(
                    name: "Koktem-2, 2",
                    latitude: 43.2273347,
                    longitude: 76.919722
                )
            ),
            yearsExpert: 6,
            description: """
            Лечение заболеваний, проводимые процедуры:
            — остеохондроз;
            — протрузии и грыжи;
            — разрыв и растяжение связок;
            — асимметрия лица;
            — боли в пояснице;
            — боли в колене;
            — боли в плече;
            — боли в шее;
            — артроз (коксартроз, гонартроз и другое);
            — сколиоз;
            — головные боли и головокружения;
            — плоскостопие.
            """,
            reviews: [
                "Дәрігер білікті, бәрін егжей-тегжейлі түсіндірді, бірінші массаждан кейін мен өзімді жақсы сезіндім",
                "Тактичность, профессионализм врача понравилось все четко объяснила, все хорошо прошло",
                "Профессиональный врач, нашла уязвимые точки над которыми нужно работать.",
                "Понравилось отношение и манера общения врача. Грамотный специалист.",
                "Вежливый, профессиональный врач. Но не то что я хотела.",
                "Барлығы ұақытында қабылдады, жақсы, сүйкімді қыз екен.",
                "такая милая девушка, облегчила боль в спине, очень хорошо все объяснила, очень красивая добрая умная девушка",
                "Хороший врач, приемом довольна.",
                "Дружелюбный, образованный специалист. Профессионал своего дела.",
                "Все понравилось, нареканий нет."
            ]
        ),
        Doctor(
            id: 3,
            type: "Rehabilitologist",
            firstName: "Askhat",
            lastName: "Mukashev",
            illustration: URL(string: "https://ms1.103.kz/images/f11f6f0850c8b35500e82bc656655bad/thumb/point=top-center,w=416,h=416,q=34,watermark=false/catalog_staff_photo/68/1f/e5/681fe5e458ad519ad3c2b6a6c23ae7d8.jpg")!,
            rating: 9.2,
            hospital: Doctor.Hospital(
                id: 1,
                name: "Expert Neuro",
                rating: 4.7,
                address: Address(
                    name: "Auezov St 67",
                    latitude: 43.2436367,
                    longitude: 76.9030064
                )
            ),
            yearsExpert: 8,
            description: """
            Специализируюсь на заболеваниях опорно-двигательного аппарата:
            — остеохондроз, протрузии, грыжи МПД;
            — сколиоз;
            — артрозо-артрит (суставов);
            — состояниях после оперативных вмешательств (грыжеиссечение МПД, артроскопии, эндопротезировании);
            — спортивных травмах (растяжение, частичные разрывы);
            — резорбция межпозвоночных грыж.
            """,
            reviews: [
                "Очень классно!"
            ]
        ),
        Doctor(
            id: 4,
            type: "Rehabilitologist",
            firstName: "Nurshat",
            lastName: "Akhmetov",
            illustration: URL(string: "https://expertneuro.kz/wp-content/uploads/2022/12/548A8969.jpg")!,
            rating: 8.9,
            hospital: Doctor.Hospital(
                id: 1,
                name: "Expert Neuro",
                rating: 4.7,
                address: Address(
                    name: "Auezov St 67",
                    latitude: 43.2436367,
                    longitude: 76.9030064
                )
            ),
            yearsExpert: 10,
            description: """
            Специализируюсь на:
            — На заболеваниях опорно-двигательного аппарата, артриты, артрозы.
            — На заболевания центральной нервной системы.
            — На заболеваниях межпозвоночных дисков позвоночника.
            — Остеохондроз, грыжа, смешение позвоночника.
            — Боли в спине различного происхождения.
            """,
            reviews: [
                "Хочу выразить свою благодарность врачу Нуршату Сайпудимовичу. Врач очень грамотный, во время лечения был всегда рядом, был всегда на связи. пришла с болью в пояснице, после лечения состояния улучшилось, спина перестала болеть. Врач всегда встречал с позитивом и это очень успокаивает во время лечения, особенно в день плазмы. В любой момент могу обращаться, отвечает сразу. Спасибо большое вы лучший!!!",
                "Всем доброго дня суток! Я хочу поблагодарить руководство и персонал клиники Expert Neuro за профессионализм! Особенно лечащего врача Ахметова Нуршата Сайпудимовича! Очень профессионально, деликатно и аккуратно относиться к своей профессии и переживает за каждого пациента. В моем случае межпозвоночная грыжа шейного отдела. Прошел один курс и уже чувствую себя лучше. Спасибо большое девушкам в процедурной за то что каждого пациента встречают с улыбкой и хорошим настроением. Спасибо большое Дариге, тоже каждый раз интересуется о здоровье пациентов, звонит и спрашивает успеваем по графику или нет, если нет то подстраиваются под мое удобное время ! Также хочу оставить благодарность ребятам с ЛФК. Всем у кого есть проблемы со здоровьем позвоночника, смело обращайтесь в Expert neuro.Всем крепкого здоровья и удачи!!!"
            ]
        ),
        Doctor(
            id: 5,
            type: "Rehabilitologist",
            firstName: "Svetlana",
            lastName: "Prokaeva",
            illustration: URL(string: "https://idoctor.kz/images/doctors/7001/6879/CQ0MkGZiKV3ggz5L2jbBxbcqTkP2By41Lipcmayi_300x300.png")!,
            rating: 9.8,
            hospital: Doctor.Hospital(
                id: 3,
                name: "Mediker Hospital International",
                rating: 4.4,
                address: Address(
                    name: "Auezov St 67",
                    latitude: 43.215356,
                    longitude: 76.9521789
                )
            ),
            yearsExpert: 18,
            description: "Прокаева Светлана Викторовна работает в сфере физиотерапии. Основная задача ее работы - это нормализация функциональной работоспособности пациента. В своей практике физиотерапевты, в основном, используют несколько методов, среди которых: холод или тепло, ультразвук, магнитные поля, массаж, физические упражнения, ультрафиолетовое излучение и т.д.",
            reviews: [
                "Рекомендую.",
                "Очень приятная внимательная профессиональная",
                "Очень приятная профессиональная"
            ]
        ),
    ]
    
    static var hospitals: [Hospital] = [
        Hospital(
            id: 1,
            name: "Expert Neuro",
            description: "Clinic for the treatment of hernia and joints",
            banner: URL(string: "https://avatars.mds.yandex.net/get-altay/5235198/2a0000017b7a10ea3e132f75fc527e2e19a7/orig")!,
            address: Address(
                name: "Auezov St 67",
                latitude: 43.2436367,
                longitude: 76.9030064
            ),
            rating: Hospital.Rating(
                score: 4.7,
                reviews: [
                    "Прошла лечение в данной клинике, у меня грыжа и были сильные боли, хочу искренне поблагодарить своего врача Арман Арғынбаевича и весь персонал клиники, в особенности тренера ЛФК Бибигуль, девочек медсестер и координатор Азиза за заботу и индивидуальный подход, спасибо вам, боли прошли и чувствую себя очень хорошо",
                    "Сначала не верила что натяжка может помочь. Но врачи тут такие молодцы! Они объяснили все детали и подобрали мне идеальную программу. Теперь я без боли.",
                    "Я теперь как новый человек! Пролечился и боли в спине исчезли. Обязательно вернусь на повторный осмотр. Спасибо всей команде!",
                    "Отличное место! Клиника чистая и уютная, врачи приветливые. После курса лечения почувствовал себя гораздо лучше! Рекомендую всем.",
                    "Ходила в клинику с болями в спине. Врачи очень внимательные и профессиональные, выслушали все жалобы и назначили лечение которое реально помогло. Спасибо вам большое!"
                ]
            ),
            doctors: [1, 3, 4]
        ),
        Hospital(
            id: 2,
            name: "Atlant Clinic",
            description: "Rehabilitation center\nWe will restore your health and confidence in movement!",
            banner: URL(string: "https://optim.tildacdn.pro/tild3535-6364-4162-b636-353238386666/-/resize/744x/-/format/webp/_M5A0226.jpg")!,
            address: Address(
                name: "Koktem-2, 2",
                latitude: 43.2273347,
                longitude: 76.919722
            ),
            rating: Hospital.Rating(
                score: 5,
                reviews: [
                    "Обратился в клинику с болями в пояснице (травмировался при занятии спортом) и с болью в плече (старая травма). Прием был у Евгения Сергеевича - настоящий профессионал своего дела. Впервые встречаю невропатолога, который сам смотрит на диске снимки МРТ и делает соответствующие выводы, а не просто смотрит на готовое заключение клиники, которая делала МРТ. Прошел курс кинезиотерапии, также делали инъекции плазмы в места травм. Спасибо большое также кенезиологу Берику Кайдаровичу, занятия очень помогли, также показал действенные упражнения. Спасибо Камиле Мухитжанлвне за PRP терапию и советы. Приятная атмосфера в клинике, весь персонал доброжелательный. Клиника помогла мне в восстановлении после травм",
                    "Я пришла в клинику с очень неприятной болью в спине, не могла ни сидеть ни стоять дольше часа. После 1 месяца лечения чувствую себя гораздо лучше) Продолжаю самостоятельно выполнять упражнения и советы, прописанные врачами. С каждым днем ощущаю прогресс."
                ]
            ),
            doctors: [2]
        ),
        Hospital(
            id: 3,
            name: "Mediker Hospital International",
            description: "Medical center",
            banner: URL(string: "https://eurobak.kz/wp-content/uploads/2023/07/mediker.png")!,
            address: Address(
                name: "Auezov St 67",
                latitude: 43.215356,
                longitude: 76.9521789
            ),
            rating: Hospital.Rating(
                score: 4.4,
                reviews: [
                    "Отличная частная клиника, хорошее обслуживание, вежливый персонал, квалифицированные врачи. Могут проводить практически любые операции. Очень удобные и комфортные палаты. Есть парковка!",
                    "Это супер новый и высококвалифицированный медцентр с высоким стандартами оказываемых услуг и там классные доктора"
                ]
            ),
            doctors: [5]
        )
    ]
}

// MARK: - MockDataProvider.workouts

extension MockDataProvider {
    static var workoutsListItems: [WorkoutListItem] {
        [
            WorkoutListItem(
                id: 1,
                kind: .fullBody,
                title: "Fullbody Workout",
                exercises: workouts.first(where: { $0.id == 1 })?.exercises.count ?? 0,
                duration: 32
            ),
            WorkoutListItem(
                id: 2,
                kind: .lowerBody,
                title: "Lower body Workout",
                exercises: workouts.first(where: { $0.id == 2 })?.exercises.count ?? 0,
                duration: 40
            ),
            WorkoutListItem(
                id: 3,
                kind: .ab,
                title: "AB Workout",
                exercises: workouts.first(where: { $0.id == 3 })?.exercises.count ?? 0,
                duration: 20
            )
        ]
    }
}

extension MockDataProvider {
    static var workouts: [Workout] {
        [
            Workout(
                id: 1,
                difficulty: "Beginner",
                equipments: [
                    Workout.Equipment(
                        icon: URL(string: "https://img.icons8.com/?size=100&id=YLFCffSVtuJb&format=png&color=000000")!,
                        title: "Skipping Rope"
                    ),
                    Workout.Equipment(
                        icon: URL(string: "https://img.icons8.com/?size=100&id=9784&format=png&color=000000")!,
                        title: "Barbell"
                    ),
                    Workout.Equipment(
                        icon: URL(string: "https://img.icons8.com/?size=100&id=yH2dpwTADh8F&format=png&color=000000")!,
                        title: "Yoga Mat"
                    ),
                    Workout.Equipment(
                        icon: URL(string: "https://img.icons8.com/?size=100&id=11085&format=png&color=000000")!,
                        title: "Bottle of Water"
                    )
                ],
                exercises: [
                    Workout.Exercise(
                        id: 1,
                        image: URL(string: "https://media.istockphoto.com/id/1202049171/photo/young-woman-running-on-a-treadmill-indoors.jpg?s=612x612&w=0&k=20&c=UydaV16X2S-7HuLIRDH2qyrMUVCLCeAaCvwS3SvJXwo=")!,
                        title: "Warm Up",
                        duration: 300,
                        repeats: nil
                    ),
                    Workout.Exercise(
                        id: 2,
                        image: URL(string: "https://images.ctfassets.net/3s5io6mnxfqz/mPjNFhIXGEQbyDbF1FiIe/23426c3ae4d2ab81c32c4e07d234bbe6/AdobeStock_418407245_2.jpeg?w=1920")!,
                        title: "Jumping Jack",
                        duration: nil,
                        repeats: 12
                    ),
                    Workout.Exercise(
                        id: 3,
                        image: URL(string: "https://www.trevorlindenfitness.com/wp-content/uploads/2016/09/Depositphotos_115488888_original.jpg")!,
                        title: "Arm Raises",
                        duration: 60,
                        repeats: nil
                    ),
                    Workout.Exercise(
                        id: 4,
                        image: URL(string: "https://cdn.yogajournal.com/wp-content/uploads/2022/06/Upward-Facing-Dog-Mod-1_Andrew-Clark-e1670972827524-1024x598.jpg")!,
                        title: "Cobra Stretch",
                        duration: 180,
                        repeats: nil
                    ),
                    Workout.Exercise(
                        id: 0,
                        image: URL(string: "https://www.blenderbottle.com/cdn/shop/files/Woman_Drinking_from_a_BlenderBottle_Protein_Shaker_Bottle_Portrait.jpg?v=1674668829&width=1500")!,
                        title: "Rest and Drink",
                        duration: 120,
                        repeats: nil
                    )
                ]
            ),
            Workout(
                id: 2,
                difficulty: "Beginner",
                equipments: [
                    Workout.Equipment(
                        icon: URL(string: "https://img.icons8.com/?size=100&id=9784&format=png&color=000000")!,
                        title: "Barbell"
                    ),
                    Workout.Equipment(
                        icon: URL(string: "https://img.icons8.com/?size=100&id=11085&format=png&color=000000")!,
                        title: "Bottle of Water"
                    )
                ],
                exercises: [
                    Workout.Exercise(
                        id: 1,
                        image: URL(string: "https://media.istockphoto.com/id/1202049171/photo/young-woman-running-on-a-treadmill-indoors.jpg?s=612x612&w=0&k=20&c=UydaV16X2S-7HuLIRDH2qyrMUVCLCeAaCvwS3SvJXwo=")!,
                        title: "Warm Up",
                        duration: 300,
                        repeats: nil
                    ),
                    Workout.Exercise(
                        id: 5,
                        image: URL(string: "https://hips.hearstapps.com/hmg-prod/images/man-exercising-at-home-royalty-free-image-1645047847.jpg?resize=980:*")!,
                        title: "Squat",
                        duration: nil,
                        repeats: 12
                    ),
                    Workout.Exercise(
                        id: 6,
                        image: URL(string: "https://hips.hearstapps.com/hmg-prod/images/glutebridge-1603107150.jpg?resize=980:*")!,
                        title: "Glute bridge",
                        duration: nil,
                        repeats: 12
                    ),
                    Workout.Exercise(
                        id: 0,
                        image: URL(string: "https://www.blenderbottle.com/cdn/shop/files/Woman_Drinking_from_a_BlenderBottle_Protein_Shaker_Bottle_Portrait.jpg?v=1674668829&width=1500")!,
                        title: "Rest and Drink",
                        duration: 120,
                        repeats: nil
                    )
                ]
            ),
            Workout(
                id: 3,
                difficulty: "Beginner",
                equipments: [
                    Workout.Equipment(
                        icon: URL(string: "https://img.icons8.com/?size=100&id=yH2dpwTADh8F&format=png&color=000000")!,
                        title: "Yoga Mat"
                    ),
                    Workout.Equipment(
                        icon: URL(string: "https://img.icons8.com/?size=100&id=11085&format=png&color=000000")!,
                        title: "Bottle of Water"
                    )
                ],
                exercises: [
                    Workout.Exercise(
                        id: 1,
                        image: URL(string: "https://media.istockphoto.com/id/1202049171/photo/young-woman-running-on-a-treadmill-indoors.jpg?s=612x612&w=0&k=20&c=UydaV16X2S-7HuLIRDH2qyrMUVCLCeAaCvwS3SvJXwo=")!,
                        title: "Warm Up",
                        duration: 300,
                        repeats: nil
                    ),
                    Workout.Exercise(
                        id: 7,
                        image: URL(string: "https://steelsupplements.com/cdn/shop/articles/Bicycle_crunch_-_cover_-_shutterstock_1420680866_1000x.jpg?v=1670162703")!,
                        title: "Bicycle crunch",
                        duration: nil,
                        repeats: 12
                    ),
                    Workout.Exercise(
                        id: 8,
                        image: URL(string: "https://hips.hearstapps.com/hmg-prod/images/hdm119918mh15842-1545237096.png?crop=0.668xw:1.00xh;0.117xw,0&resize=1200:*")!,
                        title: "Plank",
                        duration: 90,
                        repeats: nil
                    ),
                    Workout.Exercise(
                        id: 0,
                        image: URL(string: "https://www.blenderbottle.com/cdn/shop/files/Woman_Drinking_from_a_BlenderBottle_Protein_Shaker_Bottle_Portrait.jpg?v=1674668829&width=1500")!,
                        title: "Rest and Drink",
                        duration: 120,
                        repeats: nil
                    )
                ]
            )
        ]
    }
}

// MARK: - MockDataProvider.meals

extension MockDataProvider {
    static var meals: [Meal] {
        [
            Meal(kind: .breakfast, title: "Pancake", date: makeDate(hour: 7, minute: 0)),
            Meal(kind: .breakfast, title: "Pancake", date: makeDate(hour: 7, minute: 30)),
            Meal(kind: .lunch, title: "Chicken steak", date: makeDate(hour: 1, minute: 0)),
            Meal(kind: .lunch, title: "Tea", date: makeDate(hour: 1, minute: 20)),
            Meal(kind: .snacks, title: "Apple", date: makeDate(hour: 4, minute: 31)),
            Meal(kind: .dinner, title: "Salad", date: makeDate(hour: 7, minute: 10)),
        ]
    }
    
    private static func makeDate(hour: Int, minute: Int) -> Date {
        let calendar = Calendar.current
        let today = Date()
        
        let components = calendar.dateComponents([.year, .month, .day], from: today)
        var dateComponents = DateComponents()
        dateComponents.year = components.year
        dateComponents.month = components.month
        dateComponents.day = components.day
        dateComponents.hour = hour
        dateComponents.minute = minute
        return calendar.date(from: dateComponents) ?? Date()
    }
}
