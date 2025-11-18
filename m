Return-Path: <linux-api+bounces-5365-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A6C6AC8B
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 18:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 823284F4759
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CC036B051;
	Tue, 18 Nov 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netscape.net header.i=@netscape.net header.b="dzrxZ8QO"
X-Original-To: linux-api@vger.kernel.org
Received: from sonic305-21.consmr.mail.ne1.yahoo.com (sonic305-21.consmr.mail.ne1.yahoo.com [66.163.185.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF10D3002B9
	for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484818; cv=none; b=ZMyKaJ9dtKxIt7e34ym1Z5vA0zXK+60fBe7L0MaQ1Ymch7LqosZZbY19sbvSf3VOFDKdMe3z0hqhDF5VJI0lpFR1vmjoDQhmstS+UhJijm9g0kj47vAoodNXMA6A74OCJDl2hONPTjDD6ceKa+9dhf330t/huwT27yD53rbQKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484818; c=relaxed/simple;
	bh=KS62ociukMyBwGkZwAE/Xgp8jUq2blnlf0Gxkw7tAXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQw0qYQKlUHb7pmo7Q39dmLfjqAI0SwCPit31/2qhb8iG8Xm5SfV7xtC3xCaj7ciPxI4RoVaJxKsMwpFlTHV15yObbx4IY0hc9s0Jc9Yn+G9XT2Gq95MbfW0xm2qWdsfAbBmtFLAVGt7rrrN/y55VkfkSqZV0CN0VYaMTh+Z238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netscape.net; spf=pass smtp.mailfrom=netscape.net; dkim=pass (2048-bit key) header.d=netscape.net header.i=@netscape.net header.b=dzrxZ8QO; arc=none smtp.client-ip=66.163.185.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netscape.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netscape.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1763484809; bh=RCEtiA1u1QuC7OiubOGGVM/4Lxxr7mh2gJ0A5RIm45Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dzrxZ8QO0ZKWFTCvwIblLcJ+T7ORJjmpzEdKwW/0n1LjBvhWgTClu9rOcX/PxPTYA9dqDSoZIok2pEkjh2y+MdMF4J/gHxSLN427qUoXJSnW2i7mU7Ge3EvH94/M+Q5kYQvDReS+qG1mHYxYkgVU4V7Zkf3nTOqMkpcm7JEi4Bw5avK7qrGv6eMBFpEDcINDlY4JcK7oqIjmGEM+13VczgmHOYT6wP4DWu2lFCSmCel3O2xigI2iYMEeVGOIkIZWJg9Tjpj4L2sgwowAd+kwD95JU+0YG+7SNxKw/zPg8LCnWbbkGlksrq5738FfITsS+erbrqy6dExAh0aWBxuqAg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763484809; bh=HrfwVjGOh4pGRJd/+7ElVYXKkfoEqFHL6cqUxmr2reT=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GcENt4Ardd9gcggweIxz85QrLR2B6qhVCcEa9w9h/keP55aSVYMwGTdg6KfhJU0uHvuTBJxLCXqwHNYi8Pbcd9DPt9YL28u2e4bAZWLkRFE/gMqjt2J4wrg/TGW9kTffbHZeOijvdHhc5LcoDe4TON5/nrcYli8p7WbABHuV6uI3tcVwxDw7LWsuEpiSnpC7gc1dTO7m0t72OyI9UkFiMUNCV5ogyM7RSLgD+p6KVB/xuKEXUykY987yz++KeOiymLyFNL4MCN1OTa1wREC/IEjptos3n1lTbqsDZzMjpYL4y8QMCz4ReK6wDF0kqVHHs0g6eBo6Aq1rB6cRsVuPKg==
X-YMail-OSG: 6jIUZNAVM1lmfMzPGN9Wcbf5ovAVSdENZXeCvjOgwi4aMexya3LzQWLoMCfpwGV
 euymIqBar025nvKEKX7AKU5nibMqjp.rsfuXuz87M6kmNTICnzmWJeNWVYVvDQBNQQrN097DlmjX
 lYTQ5zZVlBanJTlJWcKW1qiI5Dmb2UD79mQgQnmrlvByAr_a_IklC4Z7_1SDGxENxdASGhn5rXe6
 AmsOwU8o2xDyBPJXHCWamvBYrOgxWrifnGUhVMM02JZkawDmG8qy15Xhn.q.ldBk0E_GSQerS9qI
 uiqv07cp2ltM6KOpGzvzp2.64JJ9LOa8g1GMSmDe5xj657eDiSrkichPWNE.xhVr3rExITG1Z_HL
 vQIgYdhJBQlEce4rGDEHSGAlUa.sn6uLQseqVdSFfq3qxVarnqNh_XUDYhQRpw2skZyz04AFBEKh
 tJ4tKJd1WxpHSF43yrtV54CI81qblzGS8dYWceokK0kwZXFCHdF1m71385aOEt_j8NGeOG7gUs0N
 CMipfZ_cbeyVzf48hPoMdfUpbcqCyjVdnKeBNXNU5RCnNMXDrYoh03cznPe2qrDTu9JgE3PFA3Bx
 Ryr64d0xRjShIz6IL.ZhBet_Z.UGL4CbsUbiYT1zxnN.Kcn_DY.58Js7x69gyjUoY93RiEtRV9tP
 TiW3G9NqWuhpVphIY_TX_ijB1YUIjW9VtHXtOOqRKbsEpcy59IlcZkyU7s.CKRC..WSyT8dz_v8M
 0qnquSTyiQwY8lA3b6TaUUsKT3C.pyMayBgikI42oSow7Klv7x.lxyHjjA2Ds5kMd6LIVisNmmgA
 xZ5LVz7C_P6EW_bLHzQzJwgdBZJh86y9QiSZSfUpbGRjKJthcZxruCIQtcEgI5dQxjqf.RaES62H
 gUMfOp5IhKvuj0I6WUsOheTCsSt1NwuN0DwnepZf2awHCbvQjkGLmRbf7U46QxeZLCGrQmpqy4e_
 UJnjFtNf2RLBIVh7q0xzK754dZTkYEfHMuR3qt5KRNKhFEQxUravsBSoeOlkhTuCgy0.YPlyaO1v
 bffFrGR095WJhDpgj5Y6lNwILio9ywvHB9Xneh1BpwB0xizFfUBn4bs9F5M70PZ55KVMQnlhZcF_
 cMC_QYpEHBsZyveBXD192.gm0sXzDQi_HP.MLXe8kk.fWxSRxHKyb9LwbGtbr3wAc2rgggUs3j8J
 bNU1RgdjY2.1_NJ81rUNEC9aZGiv1KKmaYomtDw3kmvDUyhWD.woiVbhtd7vthG8iLR7xR0xJMyO
 YrfkCVoqQZBEjU.wYr8Gx9I2qOjIHn8tDvmJmn8Wv..U7hLSRnS7Fgd_QpTcVqB4cDef.eBYo3L0
 fMpYv.mycTgN8fzpovFrCEUV2dtFxhF4OZrDLAul3m4QH.CT.p0TagSVF66c1HpQqxiOBE6dVMlP
 RFiF3RJ6WmclB7PJV8JMaQetkQxOu_FQ9m8wv2PhRjpPCZZKOCP65fgBsGuL_Pnsg_uqorfs52zH
 VzXoXJ823VO39UHcy61m1rHR9c.EcrTej5acjTU7jd8th8eblpkeIUGGZcOv7NyBvnrSFic_C_mQ
 .Efnbp2XjY32F2acElkQM_y3Ij0Jt.r0t00_9fMQO29pI8sBYxiVPFEUt2Z5av_ZjGJ2NtjeEnUU
 LMxM0VxnRUGhscEA0qetu8VC_RHnkMyoo.xY.IcDarKWf0bWCMg9DM0JnaCojPEfM3JIvBgpeLNs
 eYiQBO0vjQl6VH9vfwPfHQGW0FJT6.S2yn58Yca592JhvYYLO8ULQfPWzHm37D2ET.1hh56Dml59
 MH38OzIVyJE.YAGXB9iIkO1074z3JFhMjV9yY3FZL_e.NmAz3CoE3aZ0CbtzrgMf.FnBgQKdKsU4
 ll7C2xEM7Nh45GtFgaZM5DZYhUzsue7RWUqOZ50qWek7FwNl2Kn8GnNY1w6x5Iyu5xPLyZ1iCVA5
 FL_FXUI3eKnEDdsCEtGi62rxG795arniD.GdZI726kPYPz96.Jnb9NifinxT.UJoTCCW4FNVcD5n
 NNsQ6Je3rpI1LyyVc8A8cwh6C_LDjuQkdlxYHPHVuj8ikyESB2P0PVWVbT9PDxoXhKYZCvfa_ERQ
 QbBLl8I.q.fVsS.gwZG44_eKMdqQNjOTn2xRqd.ndRDPpR3UH651LLtJC9YHd7Tam5pXHBOE0Ind
 7Zawt9MN5vQ7vW58X3ZvmPGGrZkKBxOjuDxJklYcf2gXHRmMboqGYVE9uuQP72St_TqliQFsAVpm
 Z5ZbDf1hkQyHKBCqTzeCFJwdHbbqwpmIMpjiykS4-
X-Sonic-MF: <nedu@netscape.net>
X-Sonic-ID: f7fc60c8-e546-40fc-be70-f25ea8d238d3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Nov 2025 16:53:29 +0000
Received: by hermes--production-gq1-76c986f798-vwdb2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4e4d8c6ae76838aed8130d78544447b9;
          Tue, 18 Nov 2025 16:33:09 +0000 (UTC)
Message-ID: <06279d25-73d6-01f5-dcf8-8667415048d2@netscape.net>
Date: Tue, 18 Nov 2025 08:33:07 -0800
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
From: Ned Ulbricht <nedu@netscape.net>
In-Reply-To: <2846db90-fb05-41d2-b8de-c678af75a04b@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On 11/15/25 16:47, H. Peter Anvin wrote:
> On 2025-11-15 13:29, Ned Ulbricht wrote:
>> |
>> | O_TTY_INIT
>>
>> https://pubs.opengroup.org/onlinepubs/9799919799/
>>
>> That's what motivates my first-glance preference to name this new flag,
>> which will have approximately opposite behavior, as O_TTY_NOINIT.
>>
>> But as a generic abstraction, I more prefer O_KEEP.
>>
> 
> O_KEEP seems a little vague, but O_KEEPCONFIG seems like a decent name.
> 
> It seems like we don't have several new flags:
> 
> 	O_EXEC
> 	O_SEARCH
> 	O_CLOFORK
> 	O_TTY_INIT
> 	O_RSYNC
> 	O_NOCLOBBER
> 
> Some of them *may* be possible to construct with existing Linux options, I'm
> not 100% sure; in particular O_SEARCH might be the same as (O_DIRECTORY|O_PATH).
> 
> O_NOCLOBBER looks like an odd in-between between O_EXCL and
> (O_EXCL|O_NOFOLLOW); stated to be specifically to implement the shell
> "noclobber" semantic.

"(O_EXCL|O_NOFOLLOW)" provokes a thought...

As essential context, fs/open.c build_open_flags() has:

if (flags & O_CREAT) {
	op->intent |= LOOKUP_CREATE;
	if (flags & O_EXCL) {
		op->intent |= LOOKUP_EXCL;
		flags |= O_NOFOLLOW;
	}
}

if (!(flags & O_NOFOLLOW))
	lookup_flags |= LOOKUP_FOLLOW;

So with that context, just imagine hypothetically implementing both a
non-zero O_TTY_INIT flag and an O_KEEPCONFIG flag. What would
build_open_flags() look like to handle the case where userspace
simultaneously asserts both flags?  Even if it's documented, specified
as unspecified behavior, what would the code actually do?

Or, alternatively, should an hypothetical standardization insist that in
any implementation, one of O_TTY_INIT, O_KEEPCONFIG must be #define'd 0?


Ned

