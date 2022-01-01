Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6504048278A
	for <lists+linux-api@lfdr.de>; Sat,  1 Jan 2022 13:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiAAMPK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 1 Jan 2022 07:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiAAMPJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 1 Jan 2022 07:15:09 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3648C061574
        for <linux-api@vger.kernel.org>; Sat,  1 Jan 2022 04:15:09 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so27684684pjf.3
        for <linux-api@vger.kernel.org>; Sat, 01 Jan 2022 04:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=V0EbcLoZm7Ys/c6ubAuDti/pwo2Ez9qJoAOEiQXtKtwKoOFLbGW0KyI0Oq2eOBlQv4
         ++WJwMycb123HOJAHSUv6viO4IFY8ao6kZmFMbEQE7UEXKA427ypJxgSaTmJ54CyqP5q
         pgruHCeSIJrxRE6s4Gi0X+Z9G0o5TlJiBSR2k/eNE3AiOBNiYO40XxEkXdRJiJWEa8xo
         NC5WzdB4qDP/Dm6Y516+Som4biAmgh9rJRecyhw6quey44ME1tOjn9dQWENwraBMoRtB
         17pTkUKuMb0ZcUatn0uzotyfJUAe9c7wj6eUEJdNCwGn8aN1zZqMy/fL6YpyZXQVMhAm
         PhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=a6udInb4RUxNkr1r62foAXY1W8NELO7cUVeQCHEr3/ihSVo2IePwg4HoQY7kd6M639
         9t/sHuW2ZAB/9hPnQ6zEdleIJk2PCdVZVQ78nSAD3JvYyTmRZwEjzDU6kg6s4vI1yDYq
         PPcy2zsL/egqskffpwQuC6lZwtka8Ic8EaxpIalMAkBFvF/dqRi5yMgL+T8a+Pl9lLXy
         vxhvKDzzDnQwVysTqk4xOGeU53Ji3LuBJLRRwKrOYAogrC2tQH5LvmSGDUjYkt8nmOAJ
         Gpi+YKRcWBHlH0/Q4rC+FclIsQmx6jwGSJtMpmcxzumr5poTvLR+hHX6moHXL2f7UVNc
         cGMg==
X-Gm-Message-State: AOAM531C0dIgJGLW6vVgjXWjTXR62J3c+ZolSQO+hjDV2Fz44RWd6Fif
        jvKlf6N2wmoNoYvEZv8YJNY=
X-Google-Smtp-Source: ABdhPJySdv+gSpO7KnbG+mXel4s6aFFGRP+6upxzrpnmdXOnBezmczn3k9V7O+K/swa/g6WeA6ZK1w==
X-Received: by 2002:a17:902:e8c9:b0:149:b88d:5980 with SMTP id v9-20020a170902e8c900b00149b88d5980mr964574plg.171.1641039309402;
        Sat, 01 Jan 2022 04:15:09 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id c7sm33483169pjs.17.2022.01.01.04.15.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 04:15:08 -0800 (PST)
Message-ID: <61d045cc.1c69fb81.5385d.d706@mx.google.com>
From:   yalaiibrahim818@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 14:14:52 +0200
Reply-To: andres.stemmet1@gmail.com
X-Mailer: TurboMailer 2
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I want to confide in you to finalize this transaction of mutual benefits. I=
t may seem strange to you, but it is real. This is a transaction that has n=
o risk at all, due process shall be followed and it shall be carried out un=
der the ambit of the financial laws. Being the Chief Financial Officer, BP =
Plc. I want to trust and put in your care Eighteen Million British Pounds S=
terling, The funds were acquired from an over-invoiced payment from a past =
contract executed in one of my departments. I can't successfully achieve th=
is transaction without presenting you as foreign contractor who will provid=
e a bank account to receive the funds.

Documentation for the claim of the funds will be legally processed and docu=
mented, so I will need your full cooperation on this matter for our mutual =
benefits. We will discuss details if you are interested to work with me to =
secure this funds. I will appreciate your prompt response in every bit of o=
ur communication. Stay Blessed and Stay Safe.

Best Regards


Tel: +44 7537 185910
Andres  Stemmet
Email: andres.stemmet1@gmail.com  =

Chief financial officer
BP Petroleum p.l.c.

                                                                           =
                        Copyright =A9 1996-2021

