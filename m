Return-Path: <linux-api+bounces-5771-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOSwAczQeGmNtQEAu9opvQ
	(envelope-from <linux-api+bounces-5771-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 27 Jan 2026 15:50:52 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF289605E
	for <lists+linux-api@lfdr.de>; Tue, 27 Jan 2026 15:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47306308E8F5
	for <lists+linux-api@lfdr.de>; Tue, 27 Jan 2026 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E001D36682E;
	Tue, 27 Jan 2026 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xlzz6S/T"
X-Original-To: linux-api@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433035F8D0
	for <linux-api@vger.kernel.org>; Tue, 27 Jan 2026 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524873; cv=none; b=lZ9oSJtRacD4sDasFcmxUTrE4yiQJxIQiozVBMwspqet+XHlqO2EC3RdSkAQ0qnoqy95+yX5Lo8a8TyB8T23u0/byf60Cm4dlWIxZ0d98H6cUG64c1OnmS0XrEfkaYCE3YhfiwWT6ufKT/vL5nJAog8tLTEP51o2rNQy3TascVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524873; c=relaxed/simple;
	bh=OpssTI3KgwuE1Jlbg+tmdEftyNSaPFzf4uR1yEOaLWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTW8Nm4l7jXDuoJMT7I0sB2q7nEWG93bdvonvdhn4PuTaZzwQ8WSuMpZDd3zAqFYBIYD8bwW6aHhWNGyzYSnbXNZsJx19F9h68MASfZyzh7Bj8bNqQW+Gst8gAPs6m7QY4UjAPfnJXnpIqeLVaSrfq3YylDnbfTNUv45MJGiDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xlzz6S/T; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <941cd39c-1358-4823-9fe3-17cffd099eca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769524859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nE0kyu5tR04zFg2spcEjdioih9fpsoCl95ouCV6d5Ew=;
	b=Xlzz6S/T7STaVFAZh42LQKaE57LwmF2UFgCFvnC4keP/7C3vBIMr6IeEK4Z+G6EAx6kdsM
	SVogx4Fg8wbBKUZKXFFijNh19WFI3lzMjTZGeWQlfCoOq1uovx1njsviSMAqHeH0viwQ2M
	ekKrdzle8qK7+RNHht4l7YAmOBQ9790=
Date: Tue, 27 Jan 2026 22:40:41 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 4/9] bpf: Add syscall common attributes
 support for prog_load
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
References: <20260126151409.52072-1-leon.hwang@linux.dev>
 <20260126151409.52072-5-leon.hwang@linux.dev>
 <CAADnVQ+PDCV=YrFhxG3gXPC3jDPdbTmsaAOKBsFceKgEware0Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+PDCV=YrFhxG3gXPC3jDPdbTmsaAOKBsFceKgEware0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5771-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FF289605E
X-Rspamd-Action: no action



On 2026/1/27 10:43, Alexei Starovoitov wrote:
> ,
> 
> 
> On Mon, Jan 26, 2026 at 7:15 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> The log buffer of common attributes would be confusing with the one in
>> 'union bpf_attr' for BPF_PROG_LOAD.
>>
>> In order to clarify the usage of these two log buffers, they both can be
>> used for logging if:
>>
>> * They are same, including 'log_buf', 'log_level' and 'log_size'.
>> * One of them is missing, then another one will be used for logging.
>>
>> If they both have 'log_buf' but they are not same totally, return -EINVAL.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf_verifier.h |  4 +++-
>>  kernel/bpf/log.c             | 29 ++++++++++++++++++++++++++---
>>  kernel/bpf/syscall.c         |  9 ++++++---
>>  3 files changed, 35 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 4a0c5ef296b9..7eb024e83d2d 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -637,9 +637,11 @@ struct bpf_log_attr {
>>         u32 log_level;
>>         struct bpf_attrs *attrs;
>>         u32 offsetof_log_true_size;
>> +       struct bpf_attrs *attrs_common;
>>  };
>>
>> -int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs);
>> +int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
>> +                               struct bpf_attrs *attrs_common);
>>  int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log);
>>
>>  #define BPF_MAX_SUBPROGS 256
>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
>> index 457b724c4176..c0b816e84384 100644
>> --- a/kernel/bpf/log.c
>> +++ b/kernel/bpf/log.c
>> @@ -865,23 +865,41 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
>>  }
>>
>>  static int bpf_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs, u64 log_buf,
>> -                            u32 log_size, u32 log_level, int offsetof_log_true_size)
>> +                            u32 log_size, u32 log_level, int offsetof_log_true_size,
>> +                            struct bpf_attrs *attrs_common)
>>  {
>> +       const struct bpf_common_attr *common = attrs_common ? attrs_common->attr : NULL;
>> +
> 
> It seems the only point of struct bpf_attrs is to pass the attrs
> here and remember them in bpf_log_attr.
> It looks unnecessary. Also the cast to void and back to actual
> type doesn't look pretty.
> It seems all of it is to do two copy_to_bpfptr_offset() of log_true_size
> in different places,
> but libbpf will use only one, so let's do only one
> copy_to_bpfptr_offset() and simply the whole thing.
> struct bpf_log_attr only needs
>   u32 offsetof_true_size;
>   bpfptr_t uattr;
> 
> No need to introduce bpf_attrs and bpf_attrs_init() either.
> When bpf_log_attr is inited make the choice of uattr and offset.
> uattr will point at either new bpf_common_attr or old bpf_attr,
> and offsetof_true_size will have 3 possible offsets.
> 
That makes sense.

Then struct bpf_log_attr can be simplified to:

struct bpf_log_attr {
        u32 offsetof_true_size;
        u32 size;
        bpfptr_t uattr;
};

And bpf_log_attr_finalize() would become:

int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct
bpf_verifier_log *log)
{
        ...

        err = bpf_vlog_finalize(log, &log_true_size);

        size = sizeof(log_true_size);
        if (attr->size >= off + size &&
            copy_to_bpfptr_offset(attr->uattr, attr->offsetof_true_size,
&log_true_size, size))
                err = -EFAULT;

        return err;
}

Thanks,
Leon


