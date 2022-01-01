Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2FB48274F
	for <lists+linux-api@lfdr.de>; Sat,  1 Jan 2022 11:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiAAKkp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 1 Jan 2022 05:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiAAKko (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 1 Jan 2022 05:40:44 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E73C061574
        for <linux-api@vger.kernel.org>; Sat,  1 Jan 2022 02:40:44 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id m1so25419636pfk.8
        for <linux-api@vger.kernel.org>; Sat, 01 Jan 2022 02:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=eErm+18yfxwTPIUmTwYMMT8ATWREthcRzotlFuOSV/EN4r9L94K2acnJCLxg4OIsiR
         rlptxrJH+EoTNFenj7RCxx1gaZJugAam3O1Xhd+llUpllQr9zEZBJw9S4z0dbC7kA5/2
         PENlqE91/kDgKyB1uY8k5O3/G1p69s9HFVNuvJXlbjjvKxVWfEZ8S3qx67uYR9lVnigh
         cJ4iGLRkFssownl/3enWrXHLb452trQTPKETPIyofi2pbjlMhYTXS4YdrA3iLB1liGlb
         g6N5PhqQ5zQwR1knW0WyERRICuhhTdsaHmqi1FBjPI4i5d3AzLC7+WJIjiM8YlOL2BCm
         MUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=DwrUlCRAVnV61wK3X4umCS5mec6HnZowNPHLOSspJKcn3nx+Bk8Muv1O7oXH2dJue0
         1h06aB8bHTaYYz/YL6GHrDASlhY0zekeF4gCHXocpJiy3htW5Ur9hQYZoUKGvMwYSq9B
         UBHl5Z5TWUaWGuDZ29Og2JQNoVvRSX3xF9eiRwbLTgPTikqizPL6hvarM7F/ecImPeqo
         j8dzyudHwZ2TU0jBcFtflRbJ+8ZGFZ7pY4n+ZIl4nJl3n93D6HfwUUsxOGajHnW+i53L
         nB/S/ZGdwtgSm5LC7qMRk+vx5eFoTAF5S6OY6vEnZDvvcPvqMMX0j0ka2uTxpzJxMNC+
         UJ4Q==
X-Gm-Message-State: AOAM532mxeIlTXlBTDAHP4jVOlOzikm/6QYfF2oOipkb7axVCxWxwIUb
        bmaXb+1dmMJ3AHb3OWC7ozg=
X-Google-Smtp-Source: ABdhPJxxg8FwE2oMuJcg14r7ejgXQXDkZJh45vp2NJ/8PlXFi4cQxRyD9vYUF1qUqH06oCww215UcA==
X-Received: by 2002:a05:6a00:2316:b0:4bb:231c:1b92 with SMTP id h22-20020a056a00231600b004bb231c1b92mr38958641pfh.27.1641033644313;
        Sat, 01 Jan 2022 02:40:44 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id s35sm26832835pfw.193.2022.01.01.02.40.36
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 02:40:44 -0800 (PST)
Message-ID: <61d02fac.1c69fb81.dee2a.a93a@mx.google.com>
From:   hyaibe56@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 12:40:29 +0200
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

