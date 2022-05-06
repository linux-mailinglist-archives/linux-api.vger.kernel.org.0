Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76551DF12
	for <lists+linux-api@lfdr.de>; Fri,  6 May 2022 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346024AbiEFS2N (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 May 2022 14:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFS2M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 May 2022 14:28:12 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D62289BA
        for <linux-api@vger.kernel.org>; Fri,  6 May 2022 11:24:25 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id e19so7965220vsu.12
        for <linux-api@vger.kernel.org>; Fri, 06 May 2022 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Ywr/AAbKxzqinK4l/8lgvC9UDWmmURWl4OIYrXSaASE=;
        b=TCKMheDB3NtADZk6IemAj0VCnbVbaYTUHyb1p4skZllUiIYqFMXbc7erIGrNfGJ02C
         5zv8j2gwRrQWAo/kCffd21TbR85+4Q9HvSsEOHZnFz8VP0Yw8lNf1BSg4XwitHTDDj9+
         kqEFPMLIwDEH5nYoI0lvZeikUuUKFHDi3A+7UC9JoZr4W2A5elYETmc4U2OG4Q8m1WtO
         y267KoRFjy8e+y0h8bZA+CUv4Y/Uqfx2I7ZN/UzQfCiD7AFiku1fJBII1MU5QkrqtCFG
         RvPhxdA3BTVj4bzNGB9Oh4gvZ5Yj9djnY9aX62SnaFJGM1oIvbVjsYJXUNSKOGoSm/gY
         XtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Ywr/AAbKxzqinK4l/8lgvC9UDWmmURWl4OIYrXSaASE=;
        b=SbrQanpy5RUyvU4JmbM8P7BEwqlQg2ZL70JRcnXrykfkqx85XXRsAbeTZ2HvokXkD5
         6qVRCwKzj3ZQvgf/a/wvtmzabl6FYDk3uN6zOrLbXa3ytWkM/x45t62BBuiDNVsXtNjR
         gYX3WIGA+WJlcgtK7AwfZIj74UvTnk/9oy7xX09l8Su3n1vARCw4Z0YirOreM3taQkKF
         M/GJn6/fLpPKKLjhFq+L+p3Jj/ShYIDIG8ACKeKLiT+rByWw7ppqiMmQCjwUFo7dZDGS
         tgl2LtYKCOUe9Q0UmdPRl8N8lzk+M9QFVsawy061ZEMqGB0jiTkIkVujc4FtyuMPkUwq
         V8/Q==
X-Gm-Message-State: AOAM533XSTcWq10gNJSoogKWj5lAtIizey90SlyNXyrUuX11KXf8gdZW
        QXz6Js7oLi7Rgskkj+IYCDNgSqSdinJivKbyXd4=
X-Google-Smtp-Source: ABdhPJzOxi0T9MNS3sgdySq4Y8k9+8cIqQJfTNE4nzdHFufW3hcOuPkOKyEPC4udMiVDvhFj7/dFrNClBk/E9e4lrp8=
X-Received: by 2002:a05:6102:538:b0:32c:bb2d:ddce with SMTP id
 m24-20020a056102053800b0032cbb2dddcemr1493680vsa.6.1651861464224; Fri, 06 May
 2022 11:24:24 -0700 (PDT)
MIME-Version: 1.0
Sender: kalueke51@gmail.com
Received: by 2002:a67:d18a:0:0:0:0:0 with HTTP; Fri, 6 May 2022 11:24:23 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Fri, 6 May 2022 20:24:23 +0200
X-Google-Sender-Auth: 0gAS6dTmOXh0spl8t95e-qD_IVc
Message-ID: <CAKCfqfgSoBLv1meY7hXahcX0z1pwUBTqxr7KkAC7Bp2YTPA2KQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello My Dear,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs. Sophia Erick, I am diagnosed
with ovarian cancer which my doctor have confirmed that I have only
some weeks to live so I have decided you handover the sum of($
11,000,000.00) through I decided handover the money in my account to
you for help of the orphanage homes and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my details to you please
assure me that you will only take 30%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs Sophia Erick.
