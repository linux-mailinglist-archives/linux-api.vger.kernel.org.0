Return-Path: <linux-api+bounces-5392-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 920ECC74505
	for <lists+linux-api@lfdr.de>; Thu, 20 Nov 2025 14:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85D6F4E9013
	for <lists+linux-api@lfdr.de>; Thu, 20 Nov 2025 13:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961BE33A6F8;
	Thu, 20 Nov 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netscape.net header.i=@netscape.net header.b="nF0wmjBi"
X-Original-To: linux-api@vger.kernel.org
Received: from sonic310-23.consmr.mail.ne1.yahoo.com (sonic310-23.consmr.mail.ne1.yahoo.com [66.163.186.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D0258EFC
	for <linux-api@vger.kernel.org>; Thu, 20 Nov 2025 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645500; cv=none; b=U+sf44/3qskYIfbCAFcpjyLVJQMRkvHxbdkqytE6SMUXZnBJslZGA4P2vLM1o7QlUWjpexkrxkOTBqkKKOzpce/qqHA5VrVbjukqoiDgixE4p1yJX2AulBhcwG+4AOPbQBG97PLLH/ml9TyojQ2JRm9hta5w/EE01oIOenbw098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645500; c=relaxed/simple;
	bh=nYDDYk+8h6uwVUWyCoc9O6cosfnlL6nl663e7aKT0f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZE/ZgsHZOs9hhROVDemZBwOZFKJHm57G4wbJugAzWyc0iprmLNxxkGw70W0mQwkIUDDSQ7McxBKwJf30S5jKJ7Dv4gagfvOgwLwYKklzUGJYP9X68hpK1svwjNn2tw4gYA0q/J4jZ8Ge8HfzTI6dQFgw5vDzzom8YGoa6Qjxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netscape.net; spf=pass smtp.mailfrom=netscape.net; dkim=pass (2048-bit key) header.d=netscape.net header.i=@netscape.net header.b=nF0wmjBi; arc=none smtp.client-ip=66.163.186.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netscape.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netscape.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1763645492; bh=ooAP9iTM/pE+pgzb1RtgNMhInF3D/HxOO/X8AaR+3Zg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=nF0wmjBiPsQxHEEPasGo6gksJwFHWMA5E/pTx4w1Okvo7SuN8fdh/ltNYiDQwhgNrpBxvmQSSgtiq0cifjV+dxIRXk1Fvz3hJdVaiZ/QwTiUaITelfrLLTy73H4tKP7UbR/LnVELs+Dn01gbbAu8xgxs2IV7/RACkF7RLhECemNkG+Eji+xA9FT05Eq4dayR/IyqXCU1g4P7E/ri2lUsw+Y9MH51uCWTS/5qemz+BAscT5xAGQSBYTPZo1Pqc8AxZj6qBlk7E9eViWQU2HI4DwwRUNaONDvxM7ba5ou/whybLH4xW0nhikRsQVYHpCKnoZT02JhdjB1HS450sRREhw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763645492; bh=ay0BArqgCK4xK3jaTTMZPWHNw+jIYZyRPk0HFJY+u1M=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OXsCZGlnv5E6VV7+5FiYqIpjE6uNFsR7OhSM6LXyRfmtphQSwqN59oTWzUnHL97YVg51JihxKdYOQVyGENwD+5a8dg/jlOBtI+zi9FboyhpP3ggYfZ82+8Wnbp7R+fEEjtCDsXbZC8l2sYcZrjDt+SPSiw5QxCuui2KgmVZD4O8p9HNlyJRo82A3p3QMacrz6dbYmMEednfzBKXicJ6PaKicNXt70eklAj1ISIDZ2Q7BjVvqQJt/Dk8gqRBz4XXHQZWO/jJqAm64PqGkKHUQBod69+GOfCHkOzEIZ375A0vqCj4/z+Sr3eL4VTga5iWar2bymccrvVeor4Jx9N6AIw==
X-YMail-OSG: U9JqMx4VM1notgdF0Dk2PmuWTzGjqGnmuu4bygTc5J7L3Yc5aTH635JTeuBqq8_
 qpd0wGIJ7e7r9RpQfNu8En86z29.ERiLWe9sEMwnrBDUs0prrsBDMmESAmSB4FWaf3F4uM72hx0G
 .NPstGxa8GvWil6Ipp99J6cw64QW4mGCjqwoTWyPfZLxZQ4wp31KT3XVA_f3Wg8xxTrusoGZIIJU
 p3NmAYj1NZvUembrq8_T3ZcO_xwRQKbod7fYd7p70wbiVgv1qAzv71f64UgscevcuB6rZaUSz0oK
 HeNjkgAcNJZO5H4RWPVwlg2YYVPUFri4clQq_bSlQclrzA5P_vuRU0XDwKe87FkDSc4Em6a6m936
 irYz7qQH.AHHPw3xYQ.GghxJd1mIy01qNazCo1q9NgMK.fLlxuGif.EwSsky.qEuZ30IOObgN_7s
 8I_9b4olirBLK71jTzm6MtorEtxveh..TA9DEZyo77yXw7XQNAlU6b_4VrVUkFBtH.HYGNK2GV7q
 oc31XGuCZ5LaoS7Fk8JgfYj8IK61.qSGAgjONvbh42OwTFVPPVIIjZ_kfExgrZUt5cAsrEW8o4Vh
 xWmRFWxTrpZoCoI8j4eP7PSs4V8vOTyONGaEGnjZXnJq6Q_vOM3EnY7MxMrSjpYPRvSqq035iOTj
 vnoGalAZs5o49Q6SkuEtY7LgEg0_9KMbxcxii0U03ALsPlrOtFNmY_ksK1RlsLvDsaf21R2proNP
 dtUgJj.Qqj686h_d2eHD.VOp8eIOH3CB8PgLgA7JrGPoYrOeQpAbFRLc8uf7GhQD.uG6o045XxtR
 LikNZ6XmrHEL2H52okri6.iAhBeL4YOX.U_jo8RtndotzBm8UVXcZppdp1czePh7vcF.pAeuH7Tj
 LQA0nDzrYfIElOYbcLbtYNzNJeJtxIkqH.6R4LAoqAzdqKJxcO9jc_boIs4qjqnHcHwjDIxS7lci
 jmWYm8g2vqIsATfBjHnVjgrvJff8fxpMP6x9SBtZ5Cu4Ye7.6qw57dBALwEov2nrFryskrO1PIJh
 SHzCQuCEo_BIE_oMJlqUV82az.JkeYE.OOGFuyBap1WMUqz91HVUD6sW9vQJjoRHDeu5AYiMDmuE
 j75XP.kPWOZ753hRQ2wPvZtbMqyjbnyuOgNZW6L.Su6NzzhBLCmOcsU8UmeeLcwyUtq_5xKPZzwW
 IFangGY9nmstC8KgrZPGXxThU6lgtzsrZ24iA5n1NRMk_C7R6ZVwn6fIOAk005ffhHUVumseo.Zz
 TjROaukrCLFmt8oGoY.U23GhQpayPID2.w6Blb6NsDjOxIWxDQrNEY.Y3b5LQ8ZCvn.JxG6ZYnuV
 E2UR9.zmoCumIcNU28YP0MuUcGrhaQVPZ9a1KdP04D5ZI6tz18TccgfwlngJXqdma9.oHPANMaS6
 ui_cxkqj0g1bZjLqdo3qI_jEJ1cYYuM00cNmKt.Cx6kd8XQXLlCN.5kbAtwWFvZ.glPrq_4VtwaX
 gDFIeFkf4MORkMaO.VjsKZQpZI31nCgQjv1wEc0EhvAwGsUNtq7YNTrDFqXTgpapEkDERa_gJGqX
 mHvzT.m7KuLxeIK8Zk0iQrTQE.XIlgaXgM_Cm4EnETgk92jktIVoNrHZBBCDU1JxJR5UQ.I8KluR
 6IVw.W0vu5viS.2h2ShBiyPk252lLmA5VAXrNe3zRBNJ9CX3UbDDCAx8RRpssy8x8MZrG1OQyWKy
 X9j_BKuyS5NMnS4NHlFzc0OlDwZyjL0JiCIF9GQmJKQivwEpj2kpsjsNWJpPCyLTGgv4KmGMmVR_
 xcLXH3n37uslNNuqcoepn.aptpYhJUYs5WRQhrTRLxEs3sJ0TNvhUsbkF8gloPcRjnakZijGmCBB
 xFcRE5.WnrOT4ss3eDqJ2OOTI54fW2vTcdz5dwrhIqJOa5o49DHIUa4XkXGh7xg0h7j3KrXrH4Lm
 Qgan8E.Gd7UqV7ohu1.eoV5ktetYNWj86BoQctmfKI9gpy543EQOyBX1LrcCfBZ54nb_kACH872E
 f6azIkvXYJuslYn3Xt0KYN9_vIOCN3erIHDZkCj7s3pdLIrkHqCOnhLaPOCPfWMvaeNKeL54.iHY
 lphmm.5nr_hsCLc5igTLVkxqNiJU.6J1hdWx_sUe_tvSzH_5TbZPVe.FI3qb4ARzAFPqvua5tN4l
 uBTAy10dKmEOIfFYAArxpCKcEckOWv7ggj5wEYte7FF21DQ6KqCksu_ZOhBVnXcS0.BGMuQJFo9e
 xrmiqJVwcadU2yzuu.MvR1WScnReeQfQxpzdN9ms-
X-Sonic-MF: <nedu@netscape.net>
X-Sonic-ID: 676e37d7-09ca-4c83-bd07-43b068c0b120
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Nov 2025 13:31:32 +0000
Received: by hermes--production-gq1-869cc4b577-n7vfw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 999518821c423a75a84d1cc13c1757c9;
          Thu, 20 Nov 2025 13:31:30 +0000 (UTC)
Message-ID: <0d3f89a8-66c6-2ae2-9cf3-6b2aff8e1f5e@netscape.net>
Date: Thu, 20 Nov 2025 05:31:27 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: RFC: Serial port DTR/RTS - O_<something>
Content-Language: en-US
To: "H. Peter Anvin" <hpa@zytor.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, Theodore Ts'o <tytso@mit.edu>,
 Maarten Brock <Maarten.Brock@sttls.nl>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com>
 <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com>
 <20251110201933.GH2988753@mit.edu>
 <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com>
 <20251111035143.GJ2988753@mit.edu>
 <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com>
 <2025111214-doily-anyway-b24b@gregkh>
 <6DBB5931-ACD4-4174-9FCE-96C45FFC4603@zytor.com>
 <2025111241-domestic-moonstone-f75f@gregkh>
 <DD67C0CF-D330-4D40-B610-FD3EB7AA0218@zytor.com>
 <2025111227-equipment-magnetism-1443@gregkh>
 <14b1bc5c-83ac-431f-a53b-14872024b969@zytor.com>
 <alpine.DEB.2.21.2511141836130.47194@angie.orcam.me.uk>
 <B72D6F71-7C0B-4C5A-8866-25D7946E0932@zytor.com>
 <6c26eea2-6f90-f48a-9488-e7480f086c70@netscape.net>
 <2846db90-fb05-41d2-b8de-c678af75a04b@zytor.com>
 <06279d25-73d6-01f5-dcf8-8667415048d2@netscape.net>
 <f643f1f6-7e69-4be6-ac8a-7b1a3a9c402d@zytor.com>
From: Ned Ulbricht <nedu@netscape.net>
In-Reply-To: <f643f1f6-7e69-4be6-ac8a-7b1a3a9c402d@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On 11/18/25 10:05, H. Peter Anvin wrote:

>> "(O_EXCL|O_NOFOLLOW)" provokes a thought...
>>
>> As essential context, fs/open.c build_open_flags() has:
>>
>> if (flags & O_CREAT) {
>>      op->intent |= LOOKUP_CREATE;
>>      if (flags & O_EXCL) {
>>          op->intent |= LOOKUP_EXCL;
>>          flags |= O_NOFOLLOW;
>>      }
>> }

[snip]

> I had missed the bit in the spec that says that O_CREAT|O_EXCL is required to
> imply O_NOFOLLOW (as Linux indeed does as seen above.)

Fwiw, earlier today I had an ultimately unsuccessful series of searches
using the Austin Group Issue tracker at:

https://austingroupbugs.net/view_all_bug_page.php

Searched (serially): "O_EXCL", "O_NOFOLLOW", "EEXIST", "ELOOP"; all with
no other filter refinements.  Then searched filtering by 'Section'
(multiple adjacent selections): 'open' .. 'openat'. In all results,
simply eyeball-scanned 'Summary' (w/o opening most).

Apparent upshot, unless I'm mistaken, is that the exact error return is
a trivial conflict with no appreciable impact on higher levels.


In roughly same vein, FreeBSD open(2) man page, specifically at
"[EMLINK]" and "STANDARDS", might possibly be stretched to read as
implicitly encouraging that assessment.

https://man.freebsd.org/cgi/man.cgi?query=open&manpath=FreeBSD+16.0-CURRENT

Alhough I don't have a FreeBSD box available to actually test
(O_CREAT|O_EXCL|O_NOFOLLOW) symlink behavior on that platform.  (Maybe
that combo's wired to detonate tnt nasal daemons? Dunno;-)


Unfortunately, this does prompt a close re-scrutinization of linux's
open(2) man page. Notwithstanding the damn spec, the linux man page
should precisely and accurately reflect the observed error return?


Ned

