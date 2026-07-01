Return-Path: <linux-api+bounces-6751-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2Lr5BB/HRGpV0woAu9opvQ
	(envelope-from <linux-api+bounces-6751-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 01 Jul 2026 09:51:59 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F50E6EADD2
	for <lists+linux-api@lfdr.de>; Wed, 01 Jul 2026 09:51:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nXxgkaw2;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="La/XE5h8";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6751-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6751-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5882300D30E
	for <lists+linux-api@lfdr.de>; Wed,  1 Jul 2026 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4495A394EB7;
	Wed,  1 Jul 2026 07:49:29 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A53B440E
	for <linux-api@vger.kernel.org>; Wed,  1 Jul 2026 07:49:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892169; cv=none; b=IRNOTC6cultcUTeSrdcZC3Ker18n+ytVPJdz7hodyy7APkdlHmkadsGs/u7Dm3W2M4WP2dEHag6qCcjq5nKPRtZ45Dv2rijgnm8FU0ZDE06D3j/EShvS+F38tgt4K4IK1wLTc9RYFqOINura0ZM4uDKYvouM8NwN8stFeG4EUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892169; c=relaxed/simple;
	bh=Egx9zKfonwBVdkXfuEdGPk6S855zvPqzLD/eAbfoqFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Knbp/Soq0SKA0ThshSR9nV9EJQ3ypOj20C8bMzvODobYQ4FNGcsVXM6VXIgoNSuWShh/EeNQnTaGcF01gMvp3nnFp6ZcCaQJeuL0crMuXj7i0nNE7sKbUb5qrj/v7OwlEu2Xf5BlYBxFANI4ZqZBdekW52vcQN5++hy1wQKfRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nXxgkaw2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=La/XE5h8; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lVvV140816
	for <linux-api@vger.kernel.org>; Wed, 1 Jul 2026 07:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ioxIwjR0AL117kzFBXybF7cfhe6hx+h5iZJxh8s87XU=; b=nXxgkaw2mzHJ/1IS
	1rf4VfEZDPDNc4qpaQP8bdnXeePd/fo2H05mnI25TgyeX6YBFWKYHAhIkZcTKDCC
	d8z7l8KKPmnhxxzUwNaEXJ9Ni5P1JIiI2aWruoIZMD+ZEsePMccKTIPdgDeDevFi
	yrs/DGuzA4yQhLp1OM0a6l8f2O/n6aTqDRZcXMoWxJSzzHj8gIYH5bFsGnn3QUSf
	at7oOMd7Z+9vF7IO2YV8r63ADuq3z+zUikqIeYEa7HXj/kakGmyZPINV16bfDemz
	u39XkDRnAIeOkZYiMLIiAuXKaX/w2/KYDjGdNnAu7Kcei2t1Uph3dxbbdVb4pxgh
	Dj6kfw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99k84c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-api@vger.kernel.org>; Wed, 01 Jul 2026 07:49:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e62e3459fso49714085a.0
        for <linux-api@vger.kernel.org>; Wed, 01 Jul 2026 00:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782892166; x=1783496966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ioxIwjR0AL117kzFBXybF7cfhe6hx+h5iZJxh8s87XU=;
        b=La/XE5h8VbZJ7MNFuXMr07Q6da9wNnXHjFLztbsQUOVS0EUzPtWLPhNS0jSImZvqB1
         dgrTDRdwhd4tN/x06EedREoBWWvLra8loGkBg3uB6S+UsRyyzehDCCOhQCNPWrmFTf+D
         SCm+pMzBhexDHbDUH05cW3DLZnwBMx2CveIAg30Vx8/719Bsr8uAbdbDjsx2mWsL5HPc
         kfE/nO93MYAHQ28dl5uyxl2kTOJcApldguOANzwwTgyp9efjRvfEa1YB7spp1NYIgB7G
         euoVbOXa+ofXQ4nuVm6TNc4TRqUhLPXe90n9U4BDHjm5KsdQcsd1/v99xO+fpL1h9mem
         A/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782892166; x=1783496966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioxIwjR0AL117kzFBXybF7cfhe6hx+h5iZJxh8s87XU=;
        b=oaagzQNkrmbY7lu7wTIHBKfVhXyXRWzvIKHRShWsfCIEW+GucD7kawFceL6IDJL3sw
         6SjgJDFhm8C6vhdPDQfx2/eWJNWV9DC7hFWUUZwHNeZDx8Gx4saAm16Jm5y+Z+u5rXJA
         J2vct+26VxPnnr/p162BAHbiCgFxx7DCO8Ps7Quj3/HlFH1GwfbS7+cgbutcUVwqwGtO
         s/NzGTrCQOh53ve9M5Z+pnFKDG7YkgA4N0xpCzTE/T0ovCoNhePfdQl2bxvehUbkdfDa
         oMSiiGIeLX29IHSML/xTKRtWVTSQLDglCHNg0xc4tU/Msvfu8HGJxYOunachrQMJkZ64
         546g==
X-Forwarded-Encrypted: i=1; AFNElJ8VtgCm6YjSXm8an67JvprGvC9aQM470skU7t/HCZyQbaQnyvUyMK73i0e/fJO7gO3h0VSevW6GScQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CzB0pIss4CsEkvPJA1QqjLKB42loIlvQ1FspE3xrhLc+8YZB
	SQV2GOH1uAepNtE1b2fUt5+oFWWdKxNxLltJZP1TXYJF3CWeYMN73yiOqy3mom09QajQt10YIcI
	Tqgxv6d8a1jB9/aildD/DoCUW4UsuizSB2qtEIhFd4V3U4bXVcBNkg6xk/B1HHZ8=
X-Gm-Gg: AfdE7ck981iakqbBCPe80ZhNVIgqLjLOZBuTYJUsoDWRpMZNvgSPd5esGCA94NS6MmR
	VP0wYLWUGQ/vFG/C5ewr414T1EpoQaa8Q3KPA12FNtC6h4UTDurCJQO4M+1UgQRoGfVWWnvb8qV
	LFs6a2tbuDmzMWO20go9U5V4xLGkTlCyZIOtyjCR9fzj09KILvYsNktp+iBMvdO5HnLvdFDGgD/
	xv1kl40zU5FSLigZyhXCzD5FHi6NqEkg+KZPaaEKBdjcppi7Eu+F+yvp7/NMvb9jFR4n/K/U01E
	1ptJPNCPDwDWqefsrOpU0Bs3SJ/HO9JISbYcf9994hoPgoiLHgxUN44C9cOZQ6II/5iFLHKkIKo
	z8xl2LB9Va05lKLU2xZG617EoxTmb0dgLxKq9d1nJYQeG2oQO8dApZ3KvHC7oIA==
X-Received: by 2002:a05:620a:2b42:b0:92e:600d:b9ea with SMTP id af79cd13be357-92e78224b5amr72107585a.21.1782892166367;
        Wed, 01 Jul 2026 00:49:26 -0700 (PDT)
X-Received: by 2002:a05:620a:2b42:b0:92e:600d:b9ea with SMTP id af79cd13be357-92e78224b5amr72104585a.21.1782892165851;
        Wed, 01 Jul 2026 00:49:25 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756797a8besm15540687f8f.35.2026.07.01.00.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:49:19 -0700 (PDT)
Message-ID: <1df42f13-229e-465c-a5ce-40ea3bd93e8b@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:49:16 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] arm64: vdso32: Respect COMPAT_32BIT_TIME
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
 <20260630-vdso-compat_32bit_time-v2-4-520d194640dd@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630-vdso-compat_32bit_time-v2-4-520d194640dd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX1x54q/eemYdb
 rSEP7pwM17AXLJwzhudvSMHaEM2KVFARlkz6wZZfxbs1pUErwPAy77oJkIMhNV9oSH6JJYdtXSn
 3ogq7chU5l3VsV1642K9etjt+QLb+kw=
X-Proofpoint-ORIG-GUID: 764hQGcVHKCYJQij4BaJvMxxTPAKunLp
X-Proofpoint-GUID: 764hQGcVHKCYJQij4BaJvMxxTPAKunLp
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a44c687 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=gC1PrsFcNpCBvASTUOwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX+oOZ4uk3zDx/
 /kSs+WSdU5AL4NTdynVLUxEIYOI6Xwj06/13XFHeUgWv4RA2FLswCwR5pIZT4L+UyubJHjO3hQ6
 QdzFy1YsJNY+/7+eiLLeCLFBrFxi8dYcOnKGQPH4DHfHUH5Jbz3pVJstMJ1GkvCy+3OOthA8k7f
 vNgGXHBPLzHlIflLQPTqV3r8T1Y54c72TmeZTydNTOmldhJKifkxGuceOde8hm60IEJL93eO6V7
 v68+YSqmuCdmbWdYs+IJb++5/aG59cxC6+mOEi/Err+Nz3FDPCcwXD8E+nEiDOf/cH4siO97x4q
 mFYmv7B2gO8/M8F9jRHoAk0auut4JvtHqfxX/TeKV0BtMzAXzvSBTt9gucKsO23Ajze7jrQb+jj
 /Nk8sVY8jG/VMxZhareyMoj1y5WFn6n8kxpQK9eAgFyyEcUQSNkyvs6S2NTFeT+/WaeLttYyECt
 zkYuPdJekarz2yJVnSw==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6751-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:thomas.weissschuh@linutronix.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tsbogend@alpha.franken.de,m:vincenzo.frascino@arm.com,m:jstultz@google.com,m:sboyd@kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-mips@vger.kernel.org,m:arnd@arndb.de,m:linux-api@vger.kernel.org,m:sparclinux@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,linutronix.de:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_SENDER(0.00)[philmd@oss.qualcomm.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_TO(0.00)[linutronix.de,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,armlinux.org.uk,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,alpha.franken.de,google.com,davemloft.net,gaisler.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 5F50E6EADD2

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
>   arch/arm64/kernel/vdso32/vdso.lds.S      |  2 ++
>   arch/arm64/kernel/vdso32/vgettimeofday.c | 14 ++++++++------
>   2 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

