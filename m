Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0633262B537
	for <lists+linux-api@lfdr.de>; Wed, 16 Nov 2022 09:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbiKPI36 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Nov 2022 03:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiKPI3h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 Nov 2022 03:29:37 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A0630565
        for <linux-api@vger.kernel.org>; Wed, 16 Nov 2022 00:27:04 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so20792604ljk.6
        for <linux-api@vger.kernel.org>; Wed, 16 Nov 2022 00:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5iWr0Dml3nvmnir3p5kT1oKHtxFQQWFh7Xz5+526tHc=;
        b=eUxDNYovZZye+RqS4J+ifyVe/k33ysu4ePPcEdRM77GxFyT4HSIyGAk51xQ7S3A8++
         //pqzUtYIhDHg/IpblugHMylsgl8BUFF7bpED/fm/eXtvwHHIO+zTpOaLUwFX3Lx0I7+
         4vYPdCqpyDEr8CpVU/+AXjBUsVAnBoGtwbKobm5mXLdPvlNSfUca8xMYf72MONB4dBMV
         yeHDCwe0+7RN1mFvizKW1ncY3ih9T37hWgxj00448fJXbDjabiEGCaM1NrVtNXiLUUPP
         +AAvFkbbp6kuP2/507xGNRgZgtgbDk6ClC8Fq3hm9wD6114XDxfa6BBE0RFgyiq9SdpB
         1HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iWr0Dml3nvmnir3p5kT1oKHtxFQQWFh7Xz5+526tHc=;
        b=dTh9hSKIGockGA7S28nf3vMGZV8VBTje8S+gsPX3fzD3h0vV8t1FEYwYiqSlHMVfe+
         zbraOTxp/rDwrfMJ7L8QyL9TnsCgBpQfbVqjLJVXe+OZdD7wfy7e13m1PfAe/+9HyGLV
         7anBkisHB3hAEnJTu4zCvvuh7F9Ks8iPrC9TcOl6CUmM9romoSa8gzMIx8w9VVfGpCkN
         t1aoVmWVdJepbCa59ZrmLgYwjJSjJWWitkhbAoSQrAiREUzfLKo4KWt4RBmvdTn2Bpek
         GWUR2wIK4gPScU03jDSV6AHs205lT4isB+P0uhhL/79dA/Ypvg1e7kEfip/7YfnsuAvZ
         O/0Q==
X-Gm-Message-State: ANoB5pmF2wLvBciRK5TqzevjjbnAmIJbKpxUOV1it3o+qBoqCvi5hToB
        pALhteCSDbpUCeaEz1qKT7vfwDKYKrLb3hGsRK0=
X-Google-Smtp-Source: AA0mqf5hhEfx82363r5toJmvlpkYk0FQvY/2M3l/vNKv55abgxJPw/T5DVdV4XtlUFz2+R9gvMSkAYoHkq2vxGfEB5A=
X-Received: by 2002:a2e:300f:0:b0:277:7eef:1d97 with SMTP id
 w15-20020a2e300f000000b002777eef1d97mr7872655ljw.516.1668587222242; Wed, 16
 Nov 2022 00:27:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab2:7d8b:0:b0:170:a062:384 with HTTP; Wed, 16 Nov 2022
 00:27:01 -0800 (PST)
From:   Susan George <susanmonans86@gmail.com>
Date:   Wed, 16 Nov 2022 09:27:01 +0100
Message-ID: <CAOAoGObMdpWqYt5=dSeTBsADa9SXvMjugrrCXLBC6MDGwvo7YA@mail.gmail.com>
Subject: =?UTF-8?Q?Hallo_Beg=C3=BCnstigter?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hallo Beg=C3=BCnstigter

Wir m=C3=B6chten Sie dar=C3=BCber informieren, dass Ihr Ausgleichsfonds in =
H=C3=B6he
von 500.000,00 =E2=82=AC auf einer Bankomatkarte gutgeschrieben wurde, mit =
der
Sie t=C3=A4glich bis zu 3.000 =E2=82=AC bei jeder Bank Ihrer Wahl in Ihrem =
Land
abheben k=C3=B6nnen.

Kontaktieren Sie Herrn Michael Karl erhalten Sie umgehend diese
Nachricht, damit er Sie bez=C3=BCglich des Erhalts Ihrer Bankomatkarte
beraten kann. Unten ist seine Kontaktadresse

Ansprechpartner: Hr. Michael Karl
Kontakt-E-Mail: mickarl670@gmail.com

Kontaktieren Sie sie so schnell wie m=C3=B6glich mit Ihrem vollst=C3=A4ndig=
en
Namen, Ihrer Wohnadresse, Ihrer Stadt, Ihrem Land und Ihrer
Telefonnummer

Vielen Dank,
MS. Susan George
Verbindungsb=C3=BCro der Vereinten Nationen
Direktion f=C3=BCr internationale Zahlungen
