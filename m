Return-Path: <linux-api+bounces-6753-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aAq8OI/HRGpz0woAu9opvQ
	(envelope-from <linux-api+bounces-6753-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 01 Jul 2026 09:53:51 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB4E6EAE1F
	for <lists+linux-api@lfdr.de>; Wed, 01 Jul 2026 09:53:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HMfEvFRx;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UQU2B+oo;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6753-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6753-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 781AC302FC95
	for <lists+linux-api@lfdr.de>; Wed,  1 Jul 2026 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322B23C0605;
	Wed,  1 Jul 2026 07:50:45 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81AA3C060F
	for <linux-api@vger.kernel.org>; Wed,  1 Jul 2026 07:50:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892245; cv=none; b=MlVtl1UXuVJtCBiLvvD1kDrkuNnwuvzf2HFkuI7BaVAmp0bjXYyEdHyodiuXEjvM9+HUrnRc0dCYVZ0mL49j4dR0Y9jszuNfimIzv7+I6BIl/JNfMWBDQX3/SJMQW+cAsR08gXh4rl/gh4b9z3PMBdHBmk9ssExiGndJaB8Fiho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892245; c=relaxed/simple;
	bh=93sm2BTMOedB4laJKM79zV17PWAvrYmlViJMtNY7qBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maE2XT0jMmOJvs94aIwTcKBaRIMucAhljy47KQmq9nXsNKtyae+VF5C1pcsoMbK8Op1hbsG00qhndA/cl5DsaNXbHn8eerVkPHaO+dWhvd+obMlyuQy9DinisLHMaVJQwf8DPBSjVzAITe93suJWDvoXwqMKVFE1HXc9A6Wac5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HMfEvFRx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UQU2B+oo; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lTPS140736
	for <linux-api@vger.kernel.org>; Wed, 1 Jul 2026 07:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kMxsrivrDzOgZ9YW+PMIw9Z8lpknReER1Olw9eV9c6E=; b=HMfEvFRx6nTIAtVE
	sL68tzthEIkQnLnX9Rc76Z+NLktj5+RvYSmZqPoXUEE+E5o+LkIIfuBJhwlpfY+J
	RMsiwlNHkpZV8rVnPyoGGxfPrNXNI5lgDH8tqDgvkEi0b2grHF8dSFgpODSc72rh
	0EjqgCOhK8TjyWAMMdGQRQAKFqqBtvWcjIDdgCvtjeMJc+b1syAik1phPUjpeiHT
	+mHBBG2Zs+XrFMXA0iCK41ffFLvfiku70zwRFhoOXlj4J9G7qR2SE7MvpJEhyGW6
	6kHzfxIseJu5NpodNx6tFH/VgtdgKXREk5GcvUEPZwLchVew9XyUnsRofUu/umcl
	K3tSsA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99k8at-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-api@vger.kernel.org>; Wed, 01 Jul 2026 07:50:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e53b8a302so35764485a.1
        for <linux-api@vger.kernel.org>; Wed, 01 Jul 2026 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782892242; x=1783497042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kMxsrivrDzOgZ9YW+PMIw9Z8lpknReER1Olw9eV9c6E=;
        b=UQU2B+ooJr/twS4oahz3htXdnnF3e6i10vSkp7Hp6khwUwMlT6iNMZ41HMC8HC7hEi
         9tL3dsjoavlnFu6jxslBE9BKGMYyV5633hg63uZvuuyKCO60lNyYW7u36mmuWtfl/Sxe
         nIYRxA+Aa2G3QCkDwtOvEejxN/GEeSfkRltRiStvs6iiGMFaz5TsVgLCmFEkBojQ1alh
         8lz9ETZkVhf6MaZ3HrxkgZQL0aNsyXa1ZzA1fsJ+i0PvaiRLe3/ptpQ6G4id87toVYgw
         /nWnCSD5sBW88HXXqGbWJa4NRqOq/vpwkOm+H/o2Jgj6nwx/UBrpf2/itoqCTuM66Hps
         60EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782892242; x=1783497042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMxsrivrDzOgZ9YW+PMIw9Z8lpknReER1Olw9eV9c6E=;
        b=gsoezuktN309CTbHuXM8PBOuaBDSTwn9b9PAlD3NtbcT/CW0XuikAWoF/gUVpRM4q0
         nfQO44Lb2b0NHRlEMc7R4fm9ezwmEfcV16KXUrwsaA1bgCfTVUDFvuDAPR7NcGhp9aDc
         FqcfKR+8V6gIkd5mGcWd8OIeGRANCVW5+ajYsf/5MQV61JCxZrBrjD75qUzzFFNjh8dL
         pTWy8W1BTpuq188jKiAilwlZ9KJ4rgB2BijjmYEGv155V/IFB+EvnnSwhs9egZc9gWBJ
         bu7Dh9MPX7fD75m3kVS5dn/YR3N3oRSjD9uhaAAJVvZXMqWJ81If3SSnOVv+Jf7YDCgs
         vWoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zK2h5NrcDLzBoCRgAH0JcBXK+zR7twOlqYTRZebVD2GPLvvFXOlnsMLRdSM+a8HKEA2wsFNl3aMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3McoVg6IqocOJOIh1SckAEytgw6e7BOaEJzYBargQ8V47f0Gh
	GY9d9FMCV1jWGOJkGMWZ4N/4Clv5+dc4RX015wd7VhK68Grc4ShYYI2GmFa2KObcniimW6+WMQR
	T541q3XiS61GDjuDFahPnTmiQqfbJMBOoSgGqoTbISqKNNOJ1jDcem5BeSul59hU=
X-Gm-Gg: AfdE7ckL575NEcKnAFVAPQLytWMNemWJJikM5+6D9mqJkMSLRCFNFcSDDlsBhW6I7k2
	wCldTprStLANlZkyR1+uDRXBqMbF3mADgaTvK1AgFDrbp17ohYD925xcB5l9YLVMpMBrBSnQb0H
	47Yna50ovnM3NXrlQmUTw4JN4dnBxSChbyrGI49vzwKEfFDeJBuTaTxUt1lBJRg5lec+wKNxSi8
	xgY1lM/YXJGtldvx1qse6z5yUL2vHkTKTo7sI4Q/tS+1/4MeWNZ2tGxBAUHxFi7zRcZZ3glo6JG
	gAwI6HI+6kd0QsNWXbzZfDqqPkb4OFjx1iXlHcVLCW8lMv2cWMV5I0ZZ07DdWj0RhYIrz94yXU9
	yPZon6/Gsd5zbkUoyXruDP2UCy4kctZNBpt53QoMz7k89c4s58ErZliSsvx0cjQ==
X-Received: by 2002:a05:620a:4504:b0:915:8502:f7fe with SMTP id af79cd13be357-92e781f1943mr80047785a.15.1782892242432;
        Wed, 01 Jul 2026 00:50:42 -0700 (PDT)
X-Received: by 2002:a05:620a:4504:b0:915:8502:f7fe with SMTP id af79cd13be357-92e781f1943mr80042985a.15.1782892242042;
        Wed, 01 Jul 2026 00:50:42 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be82fd71sm77836705e9.15.2026.07.01.00.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:50:40 -0700 (PDT)
Message-ID: <b7922ba1-60f0-4135-8b86-e414c058a135@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:50:37 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] sparc: vdso: Respect COMPAT_32BIT_TIME
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
 <20260630-vdso-compat_32bit_time-v2-8-520d194640dd@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630-vdso-compat_32bit_time-v2-8-520d194640dd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfXzghHDSn6Mu0L
 V1c0+xJ9y0+EJyyhiu+VC1CvjZkPF0GHRt1ivOjP9x/L5UJsqUKxBL8vPmR13IoQEbfESGrJhgD
 rLGaP/+wHNTrkXQOW4E3gX2IzEuKXjk=
X-Proofpoint-ORIG-GUID: 3HjEE40QawAziM9A9F4xuTfB9WMO0qY3
X-Proofpoint-GUID: 3HjEE40QawAziM9A9F4xuTfB9WMO0qY3
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a44c6d3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=gC1PrsFcNpCBvASTUOwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfXxA8oWmvyW1W9
 IHZerm6Pfo0WE5B83FS7cuIY0X9JL980gZawiaBetYluJWKJdUT5xz7fqsB9ORFnxtntYfCd0PE
 Lt01t9/jGP63fuFurZIKjLpsYY2RNoyMxNMiXF5sFUiwuVhc3dBu6GrGven373Y/olDYZfDTacY
 R51Bx7xYwoOCY+TWln6kzF0QH6eQV/pVpbm973kRbZeUanaOtIlNhQNcCAgczrnq+Ib7/8LjjF3
 H2XrSy3B6AMOpWNrB1UTlyAumY+AgsmHwMP+++cHts9EV16FWZl7jNFUJl6N4sj/c2LQR3AaLfY
 ogK6ee7L15VohIrE85m0klpGfNaGaOU1yuCNSGbtgZIsR93v2RQHI86uwhs3el8Y7xAFkjdpdbw
 RVxKMNlXr8HBLhwQTQzDZjRF1jE0lvUFFk3QYLJMRFZv+6Xg+ZhbOQ7RU8pPkSbcfytgeYr5vKP
 eZWdz8Q27zv6OK2rfyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6753-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:thomas.weissschuh@linutronix.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tsbogend@alpha.franken.de,m:vincenzo.frascino@arm.com,m:jstultz@google.com,m:sboyd@kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-mips@vger.kernel.org,m:arnd@arndb.de,m:linux-api@vger.kernel.org,m:sparclinux@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linutronix.de:email];
	FORGED_SENDER(0.00)[philmd@oss.qualcomm.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_TO(0.00)[linutronix.de,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,armlinux.org.uk,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,alpha.franken.de,google.com,davemloft.net,gaisler.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[philmd@oss.qualcomm.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAB4E6EAE1F

On 30/6/26 09:38, Thomas WeiÃschuh wrote:
> If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
> provide any 32-bit time related functionality. This is the intended
> effect of the kconfig option and also the fallback system calls would
> also not be implemented.
> 
> Currently the kconfig option does not affect the gettimeofday() syscall,
> so also keep that in the vDSO.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   arch/sparc/vdso/vclock_gettime.c    | 4 ++++
>   arch/sparc/vdso/vdso32/vdso32.lds.S | 6 ++++--
>   2 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

