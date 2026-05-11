Return-Path: <linux-api+bounces-6311-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCsjKsMXAmoVnwEAu9opvQ
	(envelope-from <linux-api+bounces-6311-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 19:54:11 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B0513E0A
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 19:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7D0E3154D74
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DBC43E9CB;
	Mon, 11 May 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an9J+f36"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDE5438FF1
	for <linux-api@vger.kernel.org>; Mon, 11 May 2026 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519240; cv=none; b=aHFx4+P6XyuySXHc3OrECiFeCCDVNqQoLIa/YBYVwd7X4q1k5TtQ4hsV+3P5FGQpk8XdnnE3J6Aksz3sOESfnkI5Cm6QoJPZ1t2kU9qtUGGnZzDx2liHwwjdmMTjTPAPLBUldS383ysflhol68K3N5hHXbGSVUdUxPvJc6diBN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519240; c=relaxed/simple;
	bh=ttyzlAsQV2LCBXMCefThV0JUVjJzRehzxN0uxmPQx3k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mldctw5e2YycF0Q0OjwO5qixBPb9Uy1QNbJjwJ0XI5pvdaRh3MYk9cYpKs735UCdBiPbgtivspBdPQzTIdxrwT6K0DD+HcdU6arw0Tr6T1xo5yrFSMkouLeGchABOf73svFlC/PTh4MR/yltsD8bzYQ4eUMdgsdZDqS5lSvtKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=an9J+f36; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-42fdab683a9so3427807fac.1
        for <linux-api@vger.kernel.org>; Mon, 11 May 2026 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519238; x=1779124038; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuqFpulg8Nqo7DOFhcbTfsrDVhgNxZLwGvrCkArInQA=;
        b=an9J+f36HD8PwfYW0Ir4GuH815hrAhaeL6N8MUZKQiDRqK1vWyenuvvAXwPim0PZUX
         PBGKfNzNNBuaByPVVsAgiKV2Iuyh2GBFweD7xiIjZwYf0d9KyrYHlS6J57w5vYXDTx6+
         12z/Y/6KYr1LbyL10cW94Qgn+XfnavmdAZEk+dmJRwZPmRoK/IkqLPNsiRi63hGkahEU
         H+iG9SUlhESH4uWHmtiJxuFSygMP2N+Sa4u0Xb7M3MnmpDcaeGqrm7LvvMtgX25rv43J
         F/uJARN3hjZVeQV2R6cVawNxlerQ1J0qfGDXX5cyqN39vNnuDC7taPrEiKmMuEkFcOS3
         /5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519238; x=1779124038;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuqFpulg8Nqo7DOFhcbTfsrDVhgNxZLwGvrCkArInQA=;
        b=ZplxvFsbMmqMdl7+KZuTAWuHUmF9EaMcnFJYKPCL2vlWnXaDUq8EanelGntTCUkEnW
         NW2GxNUl37pT2i75yerO5CaLtTbWaxUkccU19/ozDcjjHzrMYS57yT2ulwTwxLfFzzAt
         sVmnZ/PdeLaOf34YHFaGbfxUz6hN5i69rfgQu5MjLT2gEikHbdpksR1PCsnV970wqfOQ
         P/Fb93Yoosoc980rn1YdSm1lmHHl0QJt32w+u7F238YnHlLy+hHVBHmkqsPod1ZoNWGU
         oryP0FfPhVHOTiqTIN4jt8l5SSZbOpRG2W/Ws9bzXyJS2wcX3wwrB8YMN1QEazUCmFSu
         6wMA==
X-Forwarded-Encrypted: i=1; AFNElJ9AOLSHToxkkjs+pl6DS1prYBx5nuDtR8uu/I5MZ4S9NTQg5ftyIZQZgAwnv1hY9yM1tSwpicOJiiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoT1Kj22RUiCj7PEZhK+bTzM9YzxoXmfa4oecpZ7CZ7drUrUha
	cnbTAJ7dTkCj4MNeS2SK+engqAQh7PfkaGJj5T88JPX+wDmNeT6gvD+x
X-Gm-Gg: Acq92OGoQhk+tPoTEWuUeMVZLWJsrhlH2HrTajY3qt4YjPdrng7yuMzOGU/Y+ivi+lo
	42G/4EI3hv+GM0Rhb1bOsH3KrjmFj8FMqnfW6jWMGDikwSFkEvogIwbDE88okPYkvlJZVWjKEiK
	bhy7Hnq5tZ9hcT3gSphObq7CiXacUplJIZroUdktC5VvJN7S669Wg9n7HQ2GAIT+3sNbj71MO45
	1dhJVnHh8zZAR6jikPnvRD4LPmtrrzqsMw3cSlsblrH2sgTq2PtlR0QZmRGoQp2IXhhAPvCiyaH
	96JSL6yVHeihs1jH21CDG/TrLoaJS2SqNPg3mfBifIRpF12qgcf2U5dlND5F7GJWNgCQbRl3v+e
	52hDKUrcATa2+43ndGnsPb7ULSfUhaecc46KS0z1TmGs1Vi0alkmyrOFB5Re1n67wYODkGFl07E
	ApPBVDW3xmHaaJRi7Z4ACBMrlS2+8gcjLtT11GAMV7wx53tqIwIsBEQYBO27hg3JDZ3/o0QMk+g
	anhn82TuQuBWSNp1CJB4e7mpHA=
X-Received: by 2002:a05:6870:5119:b0:433:ffeb:4525 with SMTP id 586e51a60fabf-434f66bae6emr15403715fac.26.1778519237637;
        Mon, 11 May 2026 10:07:17 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43557109b7dsm9702493fac.5.2026.05.11.10.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 10:07:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 10:07:15 -0700
Message-Id: <DIG0G9IFXF42.3O4K6XV8RGQBG@gmail.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
 <sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>,
 <shuah@kernel.org>, <brauner@kernel.org>, <sforshee@kernel.org>,
 <yuichtsu@amazon.com>, <aalbersh@redhat.com>, <willemb@google.com>,
 <kerneljasonxing@gmail.com>, <chen.dylane@linux.dev>, <yatsenko@meta.com>,
 <memxor@gmail.com>, <a.s.protopopov@gmail.com>, <ameryhung@gmail.com>,
 <rongtao@cestc.cn>, <linux-kernel@vger.kernel.org>,
 <linux-api@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>, <martin.lau@kernel.org>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v13 6/8] bpf: Add syscall common attributes
 support for map_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260511152817.89191-7-leon.hwang@linux.dev>
 <fad54bcc2f9363f61cda44680e7189ad7a510d81dc52f444a4c30a3fcd37df1d@mail.kernel.org>
In-Reply-To: <fad54bcc2f9363f61cda44680e7189ad7a510d81dc52f444a4c30a3fcd37df1d@mail.kernel.org>
X-Rspamd-Queue-Id: 5A0B0513E0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6311-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,bpf-ci];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon May 11, 2026 at 9:19 AM PDT, bot+bpf-ci wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 8433430dedb7..c15a4c26a43b 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>
> [ ... ]
>
>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
>> index fd12ad5a0338..62fe6ed18374 100644
>> --- a/kernel/bpf/log.c
>> +++ b/kernel/bpf/log.c
>
> [ ... ]
>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 2fa05ba8f161..54b43e16848a 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>
> [ ... ]
>
>> @@ -1611,6 +1632,31 @@ static int map_create(union bpf_attr *attr, bpfpt=
r_t uattr)
>>  	return err;
>>  }
>>
>> +static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_=
common_attr *attr_common,
>> +		      bpfptr_t uattr_common, u32 size_common)
>> +{
>> +	struct bpf_verifier_log *log;
>> +	struct bpf_log_attr attr_log;
>> +	int err, ret;
>> +
>> +	log =3D bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common,=
 size_common);
>> +	if (IS_ERR(log))
>> +		return PTR_ERR(log);
>> +
>> +	err =3D __map_create(attr, uattr, log);
>> +
>> +	ret =3D bpf_log_attr_finalize(&attr_log, log);
>> +	if (ret) {
>> +		if (err >=3D 0)
>> +			close_fd(err);
>> +		err =3D ret;
>
> When bpf_log_attr_finalize() returns an error (say -ENOSPC for log buffer
> truncation or -EFAULT for copy_to_user failure) after __map_create() alre=
ady
> returned a negative error (for example -EINVAL from CHECK_ATTR or -EPERM =
from
> security checks), does it make sense to overwrite the original map creati=
on
> error with the log finalization error?
>
> The result is that userspace receives -ENOSPC or -EFAULT instead of the
> actual reason the map creation failed. A user with an undersized log buff=
er
> might retry with a larger buffer expecting success, when the real issue i=
s
> that the map creation itself was rejected for a different reason.
>
> Looking at bpf_check() in kernel/bpf/verifier.c (around the verifier log
> finalization), it uses similar logic with 'err =3D ret;' reassignment. Ho=
wever,
> that doesn't appear to have the preserve-original-error comment that woul=
d
> clarify the intended behavior for this scenario.

I guess sinle line comment wouldn't hurt.

>
>> +	}
>> +
>> +free:
>
> Does anything use this free: label? The only exit path before it is the e=
arly
> return for IS_ERR(log), which correctly returns directly since log is an =
error
> pointer and doesn't need cleanup. There doesn't seem to be any 'goto free=
;'
> statement in the function.
>
> With -Wunused-label enabled by default in the kernel build (part of -Wall=
),
> this will generate a compiler warning. When building with -Werror (common=
 in
> CI configurations and allmodconfig builds), this would break the build.

good point. pls fix.

