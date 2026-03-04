Return-Path: <linux-api+bounces-5899-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFL3EHTHp2kZjwAAu9opvQ
	(envelope-from <linux-api+bounces-5899-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 04 Mar 2026 06:47:32 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5121FAF3E
	for <lists+linux-api@lfdr.de>; Wed, 04 Mar 2026 06:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8F0A300D1CA
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2026 05:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F401351C08;
	Wed,  4 Mar 2026 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wR90e6el"
X-Original-To: linux-api@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9CB34D396
	for <linux-api@vger.kernel.org>; Wed,  4 Mar 2026 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772603249; cv=none; b=ssKEZ4455bwLzpLxcdgvCrRl10COYpdBsOwft/lInwW79Hl2yut2zj0dK5YngrGtRLQa1Hp+AGOw5NvMm4aM9YeBAp2K5GJDHnaaBjZY5h9WtjBd/kdRJa1lyK+i2nW8K/rtDPGzsDq45EDy99XSNMRj4Hl5kExUqbvpAugyojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772603249; c=relaxed/simple;
	bh=wn/euQ0njXoXEa3IcAhDUjQJsCU+35ZsymX2391PKDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWSyMs0LU+TIjEY4RpkeRI3wounPToZF+fn+m0ueNKZ4VG/9cDLjdVdgKGq08RL6bcrvED/U6yCBWrXWP1CxYI9EBFZViYD4d66ojtF1is7eYmHoEYJUB0G6Mpf1HlUUdCbTGk/OQNcLE99e9c5XgIZcKQdUPy5H6cSpoDXCbcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wR90e6el; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c9cd645f-810b-4dd4-a1ed-27569dca5055@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772603245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GOvrSPoqklRKTRkSybSArOnZorW/NqBc/2B7NprcZw=;
	b=wR90e6elpMiEqeZGZ6SwxdssiYTUfmKlhBgt9tMyCWkj5hz2ELG+hVrKpoBsrwKpON9OeT
	Xzj5CY6226vzQA8VNxac4amUfpKeP1pxT/TLU4Z7m+oFZAgrB2OscoC2ovJWFyl3bh9pQD
	TwOb2KzwZlIAM3rQBbOg1+KTMUNE5kw=
Date: Wed, 4 Mar 2026 13:47:08 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 3/8] bpf: Refactor reporting log_true_size
 for prog_load
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>,
 Andrey Albershteyn <aalbersh@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung
 <ameryhung@gmail.com>, Rong Tao <rongtao@cestc.cn>,
 LKML <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com
References: <20260211151115.78013-1-leon.hwang@linux.dev>
 <20260211151115.78013-4-leon.hwang@linux.dev>
 <CAADnVQKc5H=k-++CHxs+Y1ggptRSLRcACLgVaMgOmt=QBT=dkA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQKc5H=k-++CHxs+Y1ggptRSLRcACLgVaMgOmt=QBT=dkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: AC5121FAF3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5899-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

On 4/3/26 00:32, Alexei Starovoitov wrote:
> On Wed, Feb 11, 2026 at 7:13 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]

>> @@ -6241,7 +6244,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>>                 err = map_freeze(&attr);
>>                 break;
>>         case BPF_PROG_LOAD:
>> -               err = bpf_prog_load(&attr, uattr, size);
>> +               if (from_user && size >= offsetofend(union bpf_attr, log_true_size))
>> +                       log_true_size = uattr.user + offsetof(union bpf_attr, log_true_size);
> 
> So you added 'from_user' gating because
> you replaced copy_to_bpfptr_offset() with copy_to_user()?
> This is a drastic change in behavior and you don't even talk about
> it in the commit log.
> You said "refactor". This is not a refactoring!
> 
> This is v10. The common_attr feature is useful, but
> you really need to think harder about what your patches
> are doing.
> 

Refactoring should not introduce any functional changes. If a functional
change is involved, it should be factored out of the refactoring commit
into a separate commit with an explanation in the commit log.

I'll add this to my self-review checklist.

The intention of 'from_user' was to replace copy_to_bpfptr_offset() with
copy_to_user(), since the log is always copied to the user-space buffer
when the log level is not BPF_LOG_KERNEL in
kernel/bpf/log.c::bpf_verifier_vlog().

The 'from_user' gating will be dropped in v12 to keep this patch as pure
refactoring.

Thanks,
Leon


