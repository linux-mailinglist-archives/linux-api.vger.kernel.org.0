Return-Path: <linux-api+bounces-6314-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MfcIK+TAmqJugEAu9opvQ
	(envelope-from <linux-api+bounces-6314-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 04:42:55 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C1E519017
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 04:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 907163010C38
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 02:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E94370D7B;
	Tue, 12 May 2026 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="keVpILkf"
X-Original-To: linux-api@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB58372ECC
	for <linux-api@vger.kernel.org>; Tue, 12 May 2026 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778553736; cv=none; b=PhKOnmX5naQclwg2JfrXK3adyviv7/vFV6P6IUrA8RFk2V4gOmYEG1W8GEz77jhQLPtGEzOr9/llIFVWg/2RlMJYspd8d7G7oDHxZPXwHxxIZsCrRzUrDo2T9HRj2BvGRvc4lmq2KlcfZ0qMSg/LCUppvIgggmMGtPWdVDREM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778553736; c=relaxed/simple;
	bh=WN/zyH5TjAsdfCx5x3sWZpuyGfJiYOQn7QIHoz/vjJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/SRqrUD7UJuXvgrMgOVGQ/9PdRgc2+sOFMbHS4fnrLR/qNCUD5VFIGaVqsCg4k4m0Ixt9utMceW5nSwggZYv7xRQ2PCk9J5fsTtfXcAsbuok1uOZTKUwqHCihXKAQvlfDTqdz8yopMEINZcRp1BEQGPq8EKmLBYHZ+jOtoDp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=keVpILkf; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <beaef7f8-e593-46b4-bb6a-139f4c725f06@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778553722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWcpjzaNFUlT0eYZEfFB2Sll7UEYWZTxg3erlOtFx14=;
	b=keVpILkfKNzw0AHLx1nRg9GXMT/7ZGT0uXBcPEUN3yPg2VhiqG+lDTVP26vjhq8+fL7+R/
	ll0okKxvM8BNDq79G2m2iColtV/9OX4T80Sc/KW6jNCj/I9D/LCsBmMlGWhVFlOKJLyiaG
	miytsB4mnqcBbw3Qavobu/8QI4yxJ+8=
Date: Tue, 12 May 2026 10:41:36 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 1/8] bpf: Extend BPF syscall with common
 attributes support
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org
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
References: <20260511152817.89191-2-leon.hwang@linux.dev>
 <810f123d14450d09d147d90dea25ddf5091e636542fcc5729d0594bfbd622757@mail.kernel.org>
 <DIG05KI4QZ2H.3JE4OWSK6KC29@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DIG05KI4QZ2H.3JE4OWSK6KC29@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 30C1E519017
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
	TAGGED_FROM(0.00)[bounces-6314-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

On 12/5/26 00:53, Alexei Starovoitov wrote:
> On Mon May 11, 2026 at 9:19 AM PDT, bot+bpf-ci wrote:
[...]
>>
>> Would it be better to use __aligned_u64 log_buf to match union bpf_attr and
>> preserve identical struct layouts across 32/64-bit ABIs?
> 
> bot has a point.
> 
Will fix.

Thanks,
Leon


