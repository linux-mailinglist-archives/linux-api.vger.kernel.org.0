Return-Path: <linux-api+bounces-5805-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCVXKQwShGnixgMAu9opvQ
	(envelope-from <linux-api+bounces-5805-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 05 Feb 2026 04:44:12 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFCFEE5D1
	for <lists+linux-api@lfdr.de>; Thu, 05 Feb 2026 04:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62AD03018089
	for <lists+linux-api@lfdr.de>; Thu,  5 Feb 2026 03:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A672D8398;
	Thu,  5 Feb 2026 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xXK/phHL"
X-Original-To: linux-api@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C52D949F
	for <linux-api@vger.kernel.org>; Thu,  5 Feb 2026 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770262991; cv=none; b=BDnNOLGyQjcIj5R5l2B4GCu0IIodRF6uqM3j22L9DTrU2DVYhZZAhhqeqYHIZffbVoPGRd9gszjgJH7IQnuAL4Z8LHjLvCqhb6z8rthw55P/Hp2OpXgXp41qBd0B2k7Y1aXtTELYezq5czhlhaMCYxh9gRRrxqAvWoZy1AN2zLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770262991; c=relaxed/simple;
	bh=jwdGMbxiu/Y4dwleuP0eWktJoBLc+ioNwnaDfglon6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XI8aeXR3IZoWWPUmjsVmk/4hc97J3K2BQBaJAA4t2LTtn43R7+9Jp+YfnhOWGmkHAmMmoN3A4+7LFfh7jXacUlzOnRXo5UHQidoP/TID4OF82aGz1P/UDh1X+jwEa7EfoMDp4pBY23EC1oED7whjPAMU+36wWj6ukw+5GO00lpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xXK/phHL; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a31b7f19-a22a-44ab-8ecd-9df9dead9c3d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770262978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOD8gLwrDcfrOBLWhEU1ZZqJintZJXyd9iWHIjbvro4=;
	b=xXK/phHLbwoxTnWR0132ExFAD6rd9R99ykDs+7Yx4UWKYkunp/CVFPWLBdmtzU1v5ZBjX5
	sq+ms2L4cPwa6Zd3qIqJkkjtZJmWeK0VmkS8EdxNi3hFNiB/UzBmK5ssZt0R232p0jYIJH
	QDnUffrIjCM5X6osblRX7xJhZfkly0g=
Date: Thu, 5 Feb 2026 11:42:42 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 4/9] bpf: Add syscall common attributes
 support for prog_load
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260202144046.30651-1-leon.hwang@linux.dev>
 <20260202144046.30651-5-leon.hwang@linux.dev>
 <CAEf4Bza-PM9ExqJS=Q_oj7Cqc5dvmbN_Zv9-4UnJNtsZU28FoQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bza-PM9ExqJS=Q_oj7Cqc5dvmbN_Zv9-4UnJNtsZU28FoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5805-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 4FFCFEE5D1
X-Rspamd-Action: no action



On 5/2/26 03:48, Andrii Nakryiko wrote:
> On Mon, Feb 2, 2026 at 6:42 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> BPF_PROG_LOAD can now provide log parameters through both union bpf_attr
>> and struct bpf_common_attr. Define clear conflict and precedence rules:
>>
>> - if both are provided and log_buf/log_size/log_level match, use them;
>> - if only one side provides a log buffer, use that one;
>> - if both provide log buffers but differ, return -EINVAL.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf_verifier.h |  3 ++-
>>  kernel/bpf/log.c             | 24 ++++++++++++++++++++++--
>>  kernel/bpf/syscall.c         |  3 ++-
>>  3 files changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index c805b85b6f7a..0d106fddbbc5 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -638,7 +638,8 @@ struct bpf_log_attr {
>>  };
>>
>>  int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf_attr *attr,
>> -                               bpfptr_t uattr, u32 size);
>> +                               bpfptr_t uattr, u32 size, struct bpf_common_attr *attr_common,
>> +                               bpfptr_t uattr_common, u32 size_common);
>>  int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
>>
>>  #define BPF_MAX_SUBPROGS 256
>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
>> index ff579fcba36f..345005ba98dd 100644
>> --- a/kernel/bpf/log.c
>> +++ b/kernel/bpf/log.c
>> @@ -873,10 +873,30 @@ static void bpf_log_attr_init(struct bpf_log_attr *attr_log, int offsetof_true_s
>>         attr_log->uattr = uattr;
>>  }
>>
>> +static bool bpf_log_attrs_diff(struct bpf_common_attr *common, u64 log_buf, u32 log_size,
>> +                              u32 log_level)
>> +{
>> +       return log_buf && common->log_buf && (log_buf != common->log_buf ||
>> +                                             log_size != common->log_size ||
>> +                                             log_level != common->log_level);
> 
> let's validate (unless we do this somewhere else) that if log_buf is
> set, then log_size and log_level (? not sure, maybe zero is fine) are
> set, or all three are not set. Same for common->log* fields...
> 

Ack.

Will validate 'log_buf && log_size && log_level' first.

> 
>> +}
>> +
>>  int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf_attr *attr,
>> -                               bpfptr_t uattr, u32 size)
>> +                               bpfptr_t uattr, u32 size, struct bpf_common_attr *attr_common,
>> +                               bpfptr_t uattr_common, u32 size_common)
>>  {
>> -       bpf_log_attr_init(attr_log, offsetof(union bpf_attr, log_true_size), uattr, size);
>> +       if (bpf_log_attrs_diff(attr_common, attr->log_buf, attr->log_size, attr->log_level))
>> +               return -EINVAL;
>> +
>> +       if (!attr->log_buf && attr_common->log_buf) {
>> +               attr->log_buf = attr_common->log_buf;
>> +               attr->log_size = attr_common->log_size;
>> +               attr->log_level = attr_common->log_level;
> 
> why are we setting this? Do we still have code that can access
> attr->log_buf even though we pass attr_log everywhere? If yes, should
> we still have that "split brain" code?
> 

'attr->log_buf' is accessed only in bpf_check().

> If we don't have this assignment, then I think we don't need to have
> bpf_prog_load-specific and btf_load-specific log_attr_init() helpers.
> They can be unified into generic log_attr_init, where for
> bpf_prog_load you'll pass offsetof(log_true_size) +
> attr->log_{buf,size,level}, and for btf_load you'll pass different
> offset of and btf-specific attr->btf_log*
> 
> This helper will just be making decision whether to use common_attr's
> log fields or passed directly command-specific ones.
> 
> Or what am I missing?
> 

If the log attributes differ, where should the effective
log_* values be stored?

Should they live in struct bpf_common_attr, or should we extend
struct bpf_log_attr to carry them?

Note that in v8, Alexei suggested struct bpf_log_attr only needs
  u32 offsetof_true_size;
  bpfptr_t uattr;

so I’d like to clarify the intended direction here. Once that’s clear, a
single generic log_attr_init() should be sufficient to handle this.

Thanks,
Leon

> 
>> +               bpf_log_attr_init(attr_log, offsetof(struct bpf_common_attr, log_true_size),
>> +                                 uattr_common, size_common);
>> +       } else {
>> +               bpf_log_attr_init(attr_log, offsetof(union bpf_attr, log_true_size), uattr, size);
>> +       }
>>         return 0;
>>  }
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index e81199361241..7125ea445c6c 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -6232,7 +6232,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>>                 err = map_freeze(&attr);
>>                 break;
>>         case BPF_PROG_LOAD:
>> -               err = bpf_prog_load_log_attr_init(&attr_log, &attr, uattr, size);
>> +               err = bpf_prog_load_log_attr_init(&attr_log, &attr, uattr, size, &attr_common,
>> +                                                 uattr_common, size_common);
>>                 err = err ?: bpf_prog_load(&attr, uattr, &attr_log);
>>                 break;
>>         case BPF_OBJ_PIN:
>> --
>> 2.52.0
>>


