Return-Path: <linux-api+bounces-5834-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOkUI2FqjWll2QAAu9opvQ
	(envelope-from <linux-api+bounces-5834-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 12 Feb 2026 06:51:29 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E936412A813
	for <lists+linux-api@lfdr.de>; Thu, 12 Feb 2026 06:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 322E4307555C
	for <lists+linux-api@lfdr.de>; Thu, 12 Feb 2026 05:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A701F4CA9;
	Thu, 12 Feb 2026 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dsYQo/2N"
X-Original-To: linux-api@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D677225416
	for <linux-api@vger.kernel.org>; Thu, 12 Feb 2026 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770875484; cv=none; b=ZrOXSZeaIr81IPNM6nFeVgmThcYGgaq2yjHvZmCpq/eakxUlDL2srMMoqFTkpbE4dDRxDZnoQGBICzi1o+geRimCegW+sq+/SmrCQlObmSe6mvu/N6XWcnyzb0Wyib6eiLNtFcSxx9elDOxA3BVvhowSw+JII4U6T01uF3NYaRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770875484; c=relaxed/simple;
	bh=ITFFE+Y9xAEMp5AudZR5uOd/8/E8Aen1/L0Kk1ZG32s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wz4/m24mD5urQNkgTsiZBwVULJFeqzAxYUp9d2hZOqSVo2AegiTyXZm4vNTBsMN69sGVYJ9voTmijKspYdmLbOuDicHGbI4OtO6FclAzYsmrwCGtrl3dd/xade/soRyxWn1AeqNaWs11ZoZaNmUeolcdLLmFW4jLFP5iT5avi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dsYQo/2N; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d139fff6-2f30-43f0-acac-df5d389fc416@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770875471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4H5BjXvuYmpiukksAJPTofzvZx4Nicd87hlIkcl1KmU=;
	b=dsYQo/2NRqB0Cag+DQnCxJfmsDD9nBXXmrtmzp/zBkH0/XEodaDLaHB7jzOGk6/O1e/TYO
	Ir8M/LuINHWNY8lPqSpc8YcsPiq+0kPLXSvCP/1UhQ6GWyDAnU0nUuiVcb/IzTA5G6D6mu
	DE2ef12zL8NaII23UW8Uab8BYTx8peg=
Date: Thu, 12 Feb 2026 13:50:55 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 3/8] bpf: Refactor reporting log_true_size
 for prog_load
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
References: <20260211151115.78013-1-leon.hwang@linux.dev>
 <20260211151115.78013-4-leon.hwang@linux.dev>
 <CAEf4Bzb-b+EcF1oLXA7mijL5kVmjpOuh2B+LPM9x4tAFOYHCsw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bzb-b+EcF1oLXA7mijL5kVmjpOuh2B+LPM9x4tAFOYHCsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5834-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: E936412A813
X-Rspamd-Action: no action



On 12/2/26 06:10, Andrii Nakryiko wrote:
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
> LGTM, so
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 

Thanks for the review and the Ack!

> but it caught my eye that we will never return log_true_size if
> SYSCALL program tried to load another BPF program (light skeleton
> case), which seems limiting, but we can perhaps address that
> separately as a follow up
> 

Correct.

Currently, struct bpf_verifier_log and the log_true_size
back-propagation mechanism are designed specifically for user space and
are not compatible with in-kernel callers.

I’ll look into whether this can be improved in a follow-up.

Thanks,
Leon

[...]


