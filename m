Return-Path: <linux-api+bounces-5804-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI0CKJ/+g2mvwgMAu9opvQ
	(envelope-from <linux-api+bounces-5804-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 05 Feb 2026 03:21:19 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E6EDEF4
	for <lists+linux-api@lfdr.de>; Thu, 05 Feb 2026 03:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EEA33002F5B
	for <lists+linux-api@lfdr.de>; Thu,  5 Feb 2026 02:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C19229ACC6;
	Thu,  5 Feb 2026 02:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p66kndHN"
X-Original-To: linux-api@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC7125D0
	for <linux-api@vger.kernel.org>; Thu,  5 Feb 2026 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258075; cv=none; b=Y+VnEzd71S5WMRRAzHGQOCr3wudWPZouCo75YRcGjvZnHN237HMgw5JsqSPVfadBJuh/3jUjZheW4stgyDi0UtG03U+lAHQFudtXSHqAEs/WeYGJ6HXkiVptwfb1U6Jb+eTA3dBHy+4YhWODYQbRUG66cjQkSl7DeGc6IO6NVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258075; c=relaxed/simple;
	bh=2XE8HbfhFXMkSTQ1DjZ0dz3yRk4XRucvW0j10qt/2c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWpdGQ6OUF8foLHgOvxI2Guy7su2cOHtmWIfQWPCL1R2VjIyffRK2QpLCQW/3Y46gnQPojSbE/3h+3gBEuVUX53bCacG63SZn050dm9miQ9kEc9d+UXu8bQ913dyN+OzJjHVwCltczLARroeoLzkUeCOj4GQWKY/db2QcHbywDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p66kndHN; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ff3384a-24a2-4833-b614-16d2c7227b5e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770258062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNWaH+3MFLvOh6Xfm+sXWjDEBIlfcpUNTm0CfSMiejg=;
	b=p66kndHNUsxax//oN/L/DwtqYmNC9orbMSlZws0UL5XF1SkdIFwfKWopH1SAWTT3jIe2MI
	OzLF+cjOpRIbhHhcJyHfu4gGgl4K7XBR1RpO6W84rbXW3jeHHdEqslAA0E2WOuZH8xjMrD
	WUb1VYLes3LwcjNLrOrJJLfJhPIXsmE=
Date: Thu, 5 Feb 2026 10:20:44 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 3/9] bpf: Refactor reporting log_true_size for
 prog_load
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
 <20260202144046.30651-4-leon.hwang@linux.dev>
 <CAEf4Bza+n2-tq0cGvAit23OduWbqO6teF211iPnOfp0s_ZwEPw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bza+n2-tq0cGvAit23OduWbqO6teF211iPnOfp0s_ZwEPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5804-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD0E6EDEF4
X-Rspamd-Action: no action



On 5/2/26 03:48, Andrii Nakryiko wrote:
> On Mon, Feb 2, 2026 at 6:42 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> The next commit will add support for reporting logs via extended common
>> attributes, including 'log_true_size'.
>>
>> To prepare for that, refactor the 'log_true_size' reporting logic by
>> introducing a new struct bpf_log_attr to encapsulate log-related behavior:
>>
>>  * bpf_prog_load_log_attr_init(): initialize the log fields, which will
>>    support extended common attributes in the next commit.
>>  * bpf_log_attr_finalize(): handle log finalization and write back
>>    'log_true_size' to userspace.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h          |  4 +++-
>>  include/linux/bpf_verifier.h | 10 ++++++++++
>>  kernel/bpf/log.c             | 35 +++++++++++++++++++++++++++++++++++
>>  kernel/bpf/syscall.c         |  8 +++++---
>>  kernel/bpf/verifier.c        | 13 +++----------
>>  5 files changed, 56 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index cd9b96434904..d4dbcc7ad156 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2913,7 +2913,9 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
>>                              size_t actual_size);
>>
>>  /* verify correctness of eBPF program */
>> -int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
>> +struct bpf_log_attr;
>> +int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr,
>> +             struct bpf_log_attr *attr_log);
>>
>>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>>  void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 8355b585cd18..c805b85b6f7a 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -631,6 +631,16 @@ static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
>>         return log && log->level;
>>  }
>>
>> +struct bpf_log_attr {
>> +       u32 offsetof_true_size;
>> +       u32 uattr_size;
>> +       bpfptr_t uattr;
>> +};
>> +
>> +int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf_attr *attr,
>> +                               bpfptr_t uattr, u32 size);
>> +int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
>> +
>>  #define BPF_MAX_SUBPROGS 256
>>
>>  struct bpf_subprog_arg_info {
>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
>> index a0c3b35de2ce..ff579fcba36f 100644
>> --- a/kernel/bpf/log.c
>> +++ b/kernel/bpf/log.c
>> @@ -863,3 +863,38 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
>>         }
>>         print_verifier_state(env, vstate, frameno, false);
>>  }
>> +
>> +static void bpf_log_attr_init(struct bpf_log_attr *attr_log, int offsetof_true_size, bpfptr_t uattr,
>> +                             u32 uattr_size)
>> +{
>> +       memset(attr_log, 0, sizeof(*attr_log));
>> +       attr_log->offsetof_true_size = offsetof_true_size;
>> +       attr_log->uattr_size = uattr_size;
>> +       attr_log->uattr = uattr;
>> +}
>> +
>> +int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf_attr *attr,
>> +                               bpfptr_t uattr, u32 size)
>> +{
>> +       bpf_log_attr_init(attr_log, offsetof(union bpf_attr, log_true_size), uattr, size);
>> +       return 0;
>> +}
>> +
>> +int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log)
>> +{
>> +       u32 log_true_size;
>> +       size_t size;
>> +       int err;
>> +
>> +       if (!log)
>> +               return 0;
> 
> can this ever happen? why guard against this?
> 

In patch #7, 'log' can be NULL when users do not provide 'log_buf'.

However, bpf_vlog_finalize() already guards against this case, so I'll
drop this check.

>> +
>> +       err = bpf_vlog_finalize(log, &log_true_size);
>> +
>> +       size = sizeof(log_true_size);
>> +       if (attr->uattr_size >= attr->offsetof_true_size + size &&
>> +           copy_to_bpfptr_offset(attr->uattr, attr->offsetof_true_size, &log_true_size, size))
>> +               err = -EFAULT;
> 
> minor nit: return -EFAULT;
> 

Ack.

Thanks,
Leon



