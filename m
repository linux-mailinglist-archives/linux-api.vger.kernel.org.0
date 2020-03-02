Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA810175B0D
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 13:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgCBM6g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Mar 2020 07:58:36 -0500
Received: from sonic312-20.consmr.mail.bf2.yahoo.com ([74.6.128.82]:40148 "EHLO
        sonic312-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727497AbgCBM6g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Mar 2020 07:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1583153914; bh=/GcFFbn2btZiSKYiGCo/BleXlnSRHZPoMjv/YxR5ftE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=SFsrN0XYusoDAJBPFtwd9hTxOnRHfcFZzRie4wZ3Uq2l0ctnT53LbwwDtRCeQn+CgC16FUec4xDQ7hRVUgqcgiEHXEqi7A7nO8T6/NkgvLbYETS9pBnsF0YTAzwZN+p5rRidDAbr3Qr70eBTjF7gcX4UbOoiHU/ctRR7HAeJ4CSfHbWwP2o8U+u2KpyNC7R4elQLNMed+bvmHQaqjaJ5utCpe85hcBhUZaWQOXY4DhKIWe3/ldpHFP/HwO19N3caS5SpudEydnvZVsyn1V5QKmlXloEvz3dmYLUSCv0YLYS1ZpbDnUBjmy2TDFAYo1S1sBOOdycJxQ9tUsVL+OG6eg==
X-YMail-OSG: Pve3Lg8VM1n7_oUZAtWE8RQ81zYOA2Gnwux6N2zQe4onPUH5Afv0lH9sDRAEoPv
 IGep23JQQ9MTXQz5fpOURkSgHpk9wxD9sj1KAnbm328ufIEPC.HnDqElh..Cj3Hpkrjn0mciJwC7
 .7.VaQW32MEx9zau1xlEcRAc9JZE7BCURcYcQQ6iPbyDZiC5EZm8.Q_PdocOXr39J45HnBXntYdx
 7EyL_iQXbcxQWwhLiP6G3U3RQbTlv1nLSHTQpiMVFmkmTIyNIb6wITc_NMkjAe46MYZVIL.7.GGY
 gclOLUEFzlh0SS_JFs3YCPT3f8nRpa8_uFh.IfQTSSNQVgtdOsIuQhm8A4_Msd7VjUUOM5YLZ_jg
 962NoCSmtbJDghFBhBJXIL90IbrYrZWbYOokHDIDsPRf1Vu9Jq.HVdVQGIj6wZ6b1otOeKUnNL.j
 O.YhM6uLoQNB3abxnKc8sRDc4FmE5pNSmEl5Gyaqd3GTkOeQKC0jGP0cau86KsNTeXq230CBelF0
 uk6i9P9U_6cJn8pTlr8ZC34OdQvU5MqjulY.2kBff.adOVBQlV6iFbX5yn6swLfCcX20YrN3Yr5R
 LyrHRgmQMPWAX7w16FyN30PcS6zhbXmh5rSRurR03ztl866zJ_v0OZMXeqglJniBSB4H3Xnyb_Wf
 pbkak591A24OGcLiJQFusmapuag8Phxrdk8l_wbQ_kEsqGdp6Vd4obj1Jdp09n7zsBAAsCU7ywVu
 y5W0G.RardguAdzIskMpEkaumZHHX5xxiHgSWyvuk6OeJ7RLcYjdaKCVu8z2zZrC3Ups2S628tuL
 nanM6vLEHInpUC54E7EGLw6JiNaKd5katjcRxlAAMlTQxeMGs5zRNano2Ief0qveTnhSyDKQEOkx
 ad_0bO9l8vP7qqb3gEM3gjUQY2rHX5xYEeoeK5gq7iM65Enk5sh5lRWkClCRkYL68J23lmUgLPdF
 NiPuM8pc_Rsvgio6wwztDuLD9DMNc3WeJB3AGNMbpdATSnnb5JgfoH7nrNwoIDCViCmOZFIdq52H
 kkOUwDjBp9r8ToUJ7yFp1q7YpzrxHy75fuAaOOm4WZBzV.WST1y.MOBhtBm34js0ZobvdcmvVUr9
 h7B3S2LsPWkrfSk2LFdqUzzDV2ZhyhIA8yuAlA6ZVM.a82Ope7nLgPSTtVAh6mr57loLlHzW_2U4
 zgAfC42XETBZSeKQKYnU2el2DSJA41hlwr3eVZc343US.PxyQEhCKnA7VTDsd5DkFx25e3m0ZyZo
 g24ro0J54ExMci6dzdSlqNZw2R5I.N9MJi7Pl1Aha9C4.W5woCluMCB0cwGTFuNWRlhw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Mon, 2 Mar 2020 12:58:34 +0000
Date:   Mon, 2 Mar 2020 12:58:31 +0000 (UTC)
From:   Jak Abdullah mishail <mishailjakabdullah397@gmail.com>
Reply-To: mishailjakabdullah@gmail.com
Message-ID: <1967107543.2106198.1583153911376@mail.yahoo.com>
Subject: I NEED YOUR ASSISTANCE AND CO-OPERATION TO INVEST IN YOUR COUNTRY,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1967107543.2106198.1583153911376.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15302 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:47.0) Gecko/20100101 Firefox/47.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Greeting,

My Name is Mr.Jak Abdullah mishail from Damascus Syria, and I am now resign=
ed from the government. I am a member of an opposition party goverment in S=
yria and a business man also,

I need a foreign partner to enable me transport my investment capital and t=
hen Relocate with my family, honestly I wish I will discuss more and get al=
ong I need a partner because my investment capital is in my international a=
ccount. Am interested in buying Properties, houses, building real estates a=
nd some tourist places, my capital for investment is ($16.5 million USD) Me=
anwhile if there is any profitable investment that you have so much experie=
nce on it then we can join together as partners since I=E2=80=99m a foreign=
er.

I came across your e-mail contact through private search while in need of y=
our assistance and I decided to contact you directly to ask you if you know=
 any Lucrative Business Investment in your Country I can invest my Money si=
nce my Country Syria Security and Economic Independent has lost to the Grea=
test Lower level, and our Culture has lost forever including our happiness =
has been taken away from us. Our Country has been on fire for many years no=
w.

If you are capable of handling this business Contact me for more details i =
will appreciate it if you can contact me immediately.
You may as well tell me little more about yourself. Contact me urgently to =
enable us proceed with the business.

I will be waiting for your respond.

Sincerely Yours,

Jak Abdullah mishail
