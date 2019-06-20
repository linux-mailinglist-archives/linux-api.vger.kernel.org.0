Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20455930F
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2019 06:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfF1Ex5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Jun 2019 00:53:57 -0400
Received: from mail-pf1-f232.google.com ([209.85.210.232]:45173 "EHLO
        mail-pf1-f232.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1Ex5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Jun 2019 00:53:57 -0400
Received: by mail-pf1-f232.google.com with SMTP id r1so2315498pfq.12
        for <linux-api@vger.kernel.org>; Thu, 27 Jun 2019 21:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ctcd-edu.20150623.gappssmtp.com; s=20150623;
        h=from:subject:thread-topic:thread-index:date:message-id
         :accept-language:content-language:content-transfer-encoding
         :mime-version;
        bh=uja0RKLj8/ZClYB7/xee4WJU8BS3tEVS8HkeIEY1v6o=;
        b=Pp6ugwMblAVk8EdSg2uZmnwCkjDnAeUEtYkyl/2pd63LjuHbk2LC1q+xge5CQIC/GH
         pNJGwVNnOYcmjYXoYf2oan/rFHg6jNqjzfTJF61crDfC7ANiGAwRM8eGWxPOMRhAUQyg
         lvdfAI0FfcjnvflgOXPvcA6EYs2cbKrmPfHb1o4wQKeSph2+crg4HdF4tb7L54XcZta/
         /fnDZjiJQb5VzkHj3lI0XB3f129ALqpevx0mKDb5YpjTfAqrLwH+19+2nC7YgxGKaPst
         vrV+q9eb+0yRY8GkmSrqDs/6aTIyTKO1scCH0BR7nb5KP/AyjnoZR+d5eS80Idxrzoet
         bK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:thread-topic:thread-index:date
         :message-id:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=uja0RKLj8/ZClYB7/xee4WJU8BS3tEVS8HkeIEY1v6o=;
        b=KiwgWFtfu6YZiZqTMlAnpxYwN2kKKzfWP27v5xcgbXJnJu2nYnHibxbZU3u+XNwhJ/
         2g8UhZeFUSzWOoJGXxIowyUGuWJc/Kh5yMCxpnDnlodukjGcfcAIjOgcsYRo2em5sShQ
         bva2FFMPI2EDUlba+3D7GuDK2SbelRImPJtuikFCIlntflEst098QMp52BVC95zrDx9G
         mFGnen0L5kqXgOxMI3fVna45+kEI/te8A/BzdANTnuPg4HZq/pLGTotAlan5MeLp6fiq
         QsL+8XqpSL2MHRnmDxu34PSxQYyBrDr3jLbm2/vkc0KR96d7vZYvd3wAIMunMqmVAP5C
         9Zzw==
X-Gm-Message-State: APjAAAXmaDuefcD85mrVWSuJz2eApH7gPYXofoyi/hcG3hEQOg+zR3MB
        GS0U3tjHSYJyAvRTnI6TJo9hqesdop0PcLwjcUDqjVjkQOTSnw==
X-Google-Smtp-Source: APXvYqxWnzytrw28rLZI3OWadgdZ3DWF/dwb3M14m8nGiJfU9cgSFUcH0a5rlr5KUF7rvFkqk8OObu9iTEUA
X-Received: by 2002:a17:90a:d997:: with SMTP id d23mr10147894pjv.84.1561697636500;
        Thu, 27 Jun 2019 21:53:56 -0700 (PDT)
Received: from mail.ctcd.edu (rrcs-67-79-90-89.sw.biz.rr.com. [67.79.90.89])
        by smtp-relay.gmail.com with ESMTPS id n69sm110753pjb.9.2019.06.27.21.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 21:53:56 -0700 (PDT)
X-Relaying-Domain: ctcd.edu
Received: from CTCEmail02.campus.ctcd.org (172.17.139.89) by
 CTCEmail01.campus.ctcd.org (172.17.139.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.845.34; Thu, 20 Jun 2019 09:18:40 -0500
Received: from CTCEmail02.campus.ctcd.org ([fe80::a0bb:ad1f:8c21:8800]) by
 CTCEmail02.campus.ctcd.org ([fe80::a0bb:ad1f:8c21:8800%2]) with mapi id
 15.01.0845.034; Thu, 20 Jun 2019 09:18:40 -0500
From:   "Chambers, Marcine" <MChambers@ctcd.edu>
Subject: GOOD DAY
Thread-Topic: GOOD DAY
Thread-Index: AQHVJ3MOz3fw4vybV0CezupQuoA3uw==
Date:   Thu, 20 Jun 2019 14:18:40 +0000
Message-ID: <6406a540a0c54cb4900afa0f5889c847@ctcd.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.139.254]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I am Vice Chairman of Hang Seng Bank, I have Important Matter to Discuss wi=
th you concerning my late client, Died without a NEXT OF KIN. Send me your =
private email for full details information. email me at (chienkraymond@outl=
ook.com)

Mail:infocarfer@aim.com

Regards
Dr.Raymond Chien Kuo Fung

