Return-Path: <linux-api+bounces-6329-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJIwG8TdA2qA/gEAu9opvQ
	(envelope-from <linux-api+bounces-6329-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2026 04:11:16 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151AB52C270
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2026 04:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E465301D33B
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2026 02:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBC6385516;
	Wed, 13 May 2026 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qITTtdRC"
X-Original-To: linux-api@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865A37FF5F
	for <linux-api@vger.kernel.org>; Wed, 13 May 2026 02:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638271; cv=none; b=i1Yr2O1qgktQwvxP+RlV2byBPyLqryKonjMdnvlVyf3eTrJsCK1NgQ+p5HvtsVGc2SdY8+K5Q87sPdYEgpxrS7Vh5MBFx/74XGAcGIuKQIPqX+CRN6pkeqXukidR6MwCOWl1h9eh2ZxZBzCkHVhFJS1As1Z3I4zz+NLhET0cWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638271; c=relaxed/simple;
	bh=aKdC+ll5LUjELuwn0biEITF+mfUo1RIVcG962JSBIRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWWDfaHsmEDKswF0xeMB6BRKUh7yhgBRM4+6R5b7iGTDSmep2Z3fq1Z1LY0M+JqINmIfyZHNSK2NjaqNUMBYR2q4qB8S6jwZ5MsQw175HjUJaGNWyfQjtsNbOYt/0LcpGt3cJ57l5ji6KJ91j8+JnH9E/UJEaFbmG1DqxTWBnwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qITTtdRC; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce0ad562-2da9-452d-bd54-bf98ea858eda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778638256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwYvBJrozbXYTsAqhyFYjrLi+BBFGmN36kt8esNvc24=;
	b=qITTtdRCN1UzrIKnUpaKyEYOKJX9tFb8+1X0lqJ9AwLaI6uY9Q8P8H3lNzkTY25wpuEYCv
	9oZQ9OZ/HAh5ZFKIJJ9NcFC8wFet/FXPzffTEL5g1w7yhjMDjCoZ0To1wYn5E7SmLm4UyR
	om6ctVIa5cWtVUcLiQihznVfKz3YPyg=
Date: Wed, 13 May 2026 10:10:06 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v14 2/8] libbpf: Add support for extended BPF
 syscall
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, brauner@kernel.org,
 sforshee@kernel.org, yuichtsu@amazon.com, aalbersh@redhat.com,
 willemb@google.com, kerneljasonxing@gmail.com, chen.dylane@linux.dev,
 yatsenko@meta.com, memxor@gmail.com, a.s.protopopov@gmail.com,
 ameryhung@gmail.com, rongtao@cestc.cn, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260512153157.28382-3-leon.hwang@linux.dev>
 <44819125e8a416353eb3e314e7804d2c762ea87331f98f1396eaa8b86421d950@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <44819125e8a416353eb3e314e7804d2c762ea87331f98f1396eaa8b86421d950@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 151AB52C270
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	TAGGED_FROM(0.00)[bounces-6329-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api,bpf-ci];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 13/5/26 00:23, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 5846de364209..9d8740761b7a 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
> 
> [ ... ]
> 
>> +int probe_sys_bpf_ext(void)
>> +{
>> +	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
>> +	union bpf_attr attr;
>> +	int fd;
>> +
>> +	memset(&attr, 0, attr_sz);
>> +	fd = syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr, attr_sz, NULL,
>> +		     sizeof(struct bpf_common_attr));
>> +	if (fd >= 0) {
>> +		close(fd);
>> +		return -EINVAL;
>                         ^^^^^^
> 
> Should probe_sys_bpf_ext() return 1 instead of -EINVAL when fd >= 0?
> 
> The probe function detects kernel support for extended BPF syscall
> attributes by calling the BPF syscall with the BPF_COMMON_ATTRS flag
> and a NULL pointer for common attributes.
> 
> The expected outcomes are:
> - New kernel with support: errno=EFAULT (can't copy from NULL) -> return 1
> - Old kernel without support: errno!=EFAULT (invalid command) -> return 0
> 
> If the syscall succeeds (fd >= 0), that definitively proves the kernel
> accepts the extended syscall format and supports BPF_COMMON_ATTRS. The
> function should return 1 (supported) rather than -EINVAL (error).
> 
> Returning -EINVAL causes feat_supported() in features.c to print a
> warning "Detection of kernel BPF syscall common attributes support
> support failed: Invalid argument" and mark the feature as MISSING,
> incorrectly reporting that the kernel doesn't support the feature when
> the successful syscall proves it does.
> 

Should not return 1.

This return was discussed in v5 and v6.

Cite Andrii's review in v5:

But fd should really not be >= 0, and if it is -- it's some problem,
so I'd return an error in that case to keep us aware, which is why I'm
saying I'd just return inside if (fd >= 0) { }

Thanks,
Leon

>> +	}
>> +	return errno == EFAULT ? 1 : 0;
>> +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25745661172


