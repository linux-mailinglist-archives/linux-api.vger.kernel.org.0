Return-Path: <linux-api+bounces-6453-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJL6DCzQGWoFzQgAu9opvQ
	(envelope-from <linux-api+bounces-6453-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2026 19:43:08 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4BA606BDD
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2026 19:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B571C325EA16
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2026 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AC235E1C1;
	Fri, 29 May 2026 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mvg+vmuI"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334ED3F210A;
	Fri, 29 May 2026 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073209; cv=none; b=KbYI4veY0MrnVEzvPKrhINlgZpByb+EdxvMb7wqyo19Mz1uyM/IomvHZ7bh1nGnCGrA3Oj8brEaCuNQIVFbon6CoOjhKzyvDlPUgRmKIz4dQ6AmDxq5b3JT/7K25el8490nYzApJXu6aSkgvIcYLJ+n57SvWRQYy5T0IYksI7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073209; c=relaxed/simple;
	bh=ygUI+UyBqOPq3uAn/0pT12H449HN7F3yUUECw5qqr44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kb0wdsiOdUq6jvtFCSFT61pjQfxW5mDJGx5Tn09ZcTA8WMUcYvHrcKusnAOWiw5461RCO4zIjWeMAuWe5Z8JZgZ5rCJP49FuYC11HT8pKH/y63KWRF6JkoaMbUddo7cQhPjoUsHpGeUs3wqc3bbmklt+H/udeWd0T6HoVvqIcQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mvg+vmuI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rjceQN559yBHiBpBcrgWZddsy5fV5qxnCSMQkRdxItg=; b=mvg+vmuIG/jTPG4UCyUgkfFHDh
	ugV+xPvBnWpvFM1mHw+0B+aZxEQZp05WnjtDCN+pr1PqJfia/FJqutvDNuOFvdSzmuebxL3kRiv2C
	EL6teyyYt8zc3JUhjTYGGDiOiDPql0uRQCrQXr0wxP+qPE1mHDCs3hKxxNlSuGdVmlTf0ewZ5m4k4
	rahHLMQ9BAFqR8Ilkj9qisQc0xnwHAptHghYva38JA1mo67KzKUfbpTQ73ZaS2sb9a6T/YTnhfRIr
	DvEiwhbSFw99LU4OHk5hodhyy3Qc2MCCcMoYhQmhrRqKheMVMCVZ5gp7pzaF9tErH3Sy60ZPiZq78
	BPB6fMfA==;
Received: from [179.118.191.12] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wT0Lx-009x9D-V5; Fri, 29 May 2026 18:46:34 +0200
Message-ID: <6a58fd9c-1a69-403d-ad13-32bddea666f3@igalia.com>
Date: Fri, 29 May 2026 13:46:27 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] treewide: Replace memcpy(..., current->comm) with
 strscpy()
To: David Laight <david.laight.linux@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, willy@infradead.org,
 mathieu.desnoyers@efficios.com,
 Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org,
 Yafang Shao <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com,
 arnaldo.melo@gmail.com, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, linux-mm@kvack.org,
 linux-api@vger.kernel.org
References: <20260524-tonyk-long_name-v2-0-332f6bd041c4@igalia.com>
 <20260524-tonyk-long_name-v2-3-332f6bd041c4@igalia.com>
 <20260526190625.3f4aca0a@gandalf.local.home>
 <20260527101842.376d567f@pumpkin>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260527101842.376d567f@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6453-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,goodmis.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.777];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,kernel.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,igalia.com,kvack.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,igalia.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: 9D4BA606BDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Em 27/05/2026 06:18, David Laight escreveu:
> On Tue, 26 May 2026 19:06:25 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Sun, 24 May 2026 19:38:53 -0300
>> André Almeida <andrealmeid@igalia.com> wrote:
>>
>>> In order to increase the size of current->comm[] and to avoid breaking any
>>> existing code, replace memcpy() with strscpy(). The later function makes
>>> sure that the copy is NUL terminated. This is crucial given that the
>>> source buffer might be larger than the destination buffer and could
>>> truncate the NUL character out of it.
> ...
>> As tracing now slows it down by 3.9% which is a significant increase from 2.7%
>>
>> I really rather keep memcpy() here.

Thanks Steve for taking the time for benchmarking this!

> 
> I suspect the copies could/should be replaced by a copy_task_comm()
> function that can perform optimisations that strscpy[_pad]() can't
> do because it can (for example) assume that the source is terminated.
> 
> When the src and dst are the same size it can also degenerate to
> memcpy() - which should get inlined.
> The cost of copying 64 bytes might still be rather more than copying
> just 16.
> A compromise of 32 may be better.
> 
Ok, I will work on something like this for the v3.

