Return-Path: <linux-api+bounces-5806-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIU7L2oShGkTyAMAu9opvQ
	(envelope-from <linux-api+bounces-5806-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 05 Feb 2026 04:45:46 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFD3EE5EF
	for <lists+linux-api@lfdr.de>; Thu, 05 Feb 2026 04:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A283010167
	for <lists+linux-api@lfdr.de>; Thu,  5 Feb 2026 03:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B310A2E62B5;
	Thu,  5 Feb 2026 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P2N0/gsD"
X-Original-To: linux-api@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921410F2
	for <linux-api@vger.kernel.org>; Thu,  5 Feb 2026 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770263143; cv=none; b=Px8PP4s7sD+/6wiHvhaNUkmwwOJ90ndVxl/b2e+8IKb2eOrsNwsjDxVhtT/8czH6maLX74ScU/My6Y9HOrfClad5+8FnI4KOVv6AFjyIq1DeKSucfOLK35iKayItWX7yxWu8t/fMbvOyfTULduHLVb0LM+s5o5KqEnteUyhuWRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770263143; c=relaxed/simple;
	bh=WJ/jeHkIfNNujYEUHSpYWtmxLO6yVMycMG1TYHXvJ/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESWHXZLzNbP89xLsYF02fLU1iRspfi053ydS75Zjbxcjh0mOIfqqk5eAKficVtJfz/pllySzyQ0LY55x3Ic4wAoPBwupjYd6bwqFEuRUdjFKX4ZyP0cAz4kWEButJApSwa1/d2W9olN89Z/rzZPQVsayqeUoX10JdCkWaC9YCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P2N0/gsD; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da08f1b6-53da-4774-a05f-072260e4a797@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770263131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikkVCtqFFnuGi3PCNZVDX6A6swIGnFYJIrnmzPcH2b4=;
	b=P2N0/gsD+bqwC6ZgFow5sgOtkoDtUELLLhFP/R4AemtFYv4ne/e0HWcKQZSAgRI0g0n6u+
	OluPkCP/SWLydIxuWA9jKWAesBekbg+JyIV2iN3pYJm1GHcjuV6iRY24lR8cS1uT40ZIy7
	rooxv3GMniRBsv4ZERBF5+vAaXsQslw=
Date: Thu, 5 Feb 2026 11:45:14 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 8/9] libbpf: Add syscall common attributes
 support for map_create
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
 <20260202144046.30651-9-leon.hwang@linux.dev>
 <CAEf4Bzb=96Ja38VGBr9YGGSSjaWwhkfH_oWjMJULykA-a7jZxA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bzb=96Ja38VGBr9YGGSSjaWwhkfH_oWjMJULykA-a7jZxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5806-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 5DFD3EE5EF
X-Rspamd-Action: no action



On 5/2/26 03:48, Andrii Nakryiko wrote:
> On Mon, Feb 2, 2026 at 6:43 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> With the previous commit adding common attribute support for
>> BPF_MAP_CREATE, users can now retrieve detailed error messages when map
>> creation fails via the log_buf field.
>>
>> Introduce struct bpf_log_opts with the following fields:
>> log_buf, log_size, log_level, and log_true_size.
>>
>> Extend bpf_map_create_opts with a new field log_opts, allowing users to
>> capture and inspect log messages on map creation failures.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/bpf.c | 16 +++++++++++++++-
>>  tools/lib/bpf/bpf.h | 17 ++++++++++++++++-
>>  2 files changed, 31 insertions(+), 2 deletions(-)
>>
> 
> LGTM
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 

Thanks for your review.

>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 9d8740761b7a..0c3e40844d80 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -209,6 +209,9 @@ int bpf_map_create(enum bpf_map_type map_type,
>>                    const struct bpf_map_create_opts *opts)
>>  {
>>         const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
>> +       const size_t attr_common_sz = sizeof(struct bpf_common_attr);
>> +       struct bpf_common_attr attr_common;
>> +       struct bpf_log_opts *log_opts;
>>         union bpf_attr attr;
>>         int fd;
>>
>> @@ -242,7 +245,18 @@ int bpf_map_create(enum bpf_map_type map_type,
>>         attr.excl_prog_hash = ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL));
>>         attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
>>
>> -       fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
>> +       log_opts = OPTS_GET(opts, log_opts, NULL);
>> +       if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
>> +               memset(&attr_common, 0, attr_common_sz);
>> +               attr_common.log_buf = ptr_to_u64(OPTS_GET(log_opts, log_buf, NULL));
>> +               attr_common.log_size = OPTS_GET(log_opts, log_size, 0);
>> +               attr_common.log_level = OPTS_GET(log_opts, log_level, 0);
>> +               fd = sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &attr_common, attr_common_sz);
>> +               OPTS_SET(log_opts, log_true_size, attr_common.log_true_size);
>> +       } else {
>> +               fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
>> +               OPTS_SET(log_opts, log_true_size, 0);
>> +       }
>>         return libbpf_err_errno(fd);
>>  }
>>
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 2c8e88ddb674..59673f094f86 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -37,6 +37,18 @@ extern "C" {
>>
>>  LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
>>
>> +struct bpf_log_opts {
>> +       size_t sz; /* size of this struct for forward/backward compatibility */
>> +
>> +       char *log_buf;
>> +       __u32 log_size;
>> +       __u32 log_level;
>> +       __u32 log_true_size;
> 
> please mention in the comment here that this is an out parameter set
> by the kernel
> 

Ack.

I'll add a comment in the next revision.

Thanks,
Leon

>> +
>> +       size_t :0;
>> +};
>> +#define bpf_log_opts__last_field log_true_size
>> +
>>  struct bpf_map_create_opts {
>>         size_t sz; /* size of this struct for forward/backward compatibility */
>>
>> @@ -57,9 +69,12 @@ struct bpf_map_create_opts {
>>
>>         const void *excl_prog_hash;
>>         __u32 excl_prog_hash_size;
>> +
>> +       struct bpf_log_opts *log_opts;
>> +
>>         size_t :0;
>>  };
>> -#define bpf_map_create_opts__last_field excl_prog_hash_size
>> +#define bpf_map_create_opts__last_field log_opts
>>
>>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>>                               const char *map_name,
>> --
>> 2.52.0
>>


