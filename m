Return-Path: <linux-api+bounces-1826-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4E592468D
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 19:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A74E28174C
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A284E1BE225;
	Tue,  2 Jul 2024 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EGvKwXxK"
X-Original-To: linux-api@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44563D978;
	Tue,  2 Jul 2024 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941860; cv=none; b=ngxz4F+tEHWAXhSuhJxNKEa1eC/2ZOKXd/6E/dK6kxOs7tmScNNeEOouf5nzsMktAbtIJyNzGCuBoT8yR9T2p8sddSC7VGyB9OOmTQSUyKdhcX1YBGKHBsPTAbtmfkOQoAFDCaZNgaRPawkT8eku56VRLW6SV+GRgKs4wiFdxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941860; c=relaxed/simple;
	bh=/2A8bz/WUlwR9rk6cjNCv2bK6UDxNPWNhwZ6FREREq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM/Trxjit+iDBDspeAScGqzbnwBa7Lrec9BMSdHhOC3D4HgmATlh1MBj43Gw8AcmJtFpq9Dbw8vNS1Fm1hkrwF8Da+ucO+uTsNaxWB0e0WzCPTV149ndrt9LvyzvphXee2RpS2WGfzQ2UcJqUJ8n2S3ux1wOhuP0er/oKun+9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EGvKwXxK; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719941856;
	bh=/2A8bz/WUlwR9rk6cjNCv2bK6UDxNPWNhwZ6FREREq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EGvKwXxKye1hcoiqUR/QpqOSiNHnwQdrAWhPy1kCoXaFVTJAhNlf5Ahqbs+u/J6+o
	 HN5FzpuSri5CjlJyuvpq7Qv+lM1VSV9ahoAAeM1Ay/d+XTdVHtXmexrhiNkBHCAZlN
	 cn9IGIONz7ja2bPol25hYE7oNlZNnUD1Hx6Dr2IuwI3nCu/wEVfIDDosEdd2COMuaB
	 2/37JXLQEn9a0Zicx/6irek+RDat/hASSgVB8nmeFbTwLFGFXAkXzQdQrqN5S6ZtM1
	 0Ui27WVRB5QOZLMZmyRAew5WYTVqb5Hxhep8VHlkIRupm+1F7I1bKJrISlUb6LPKix
	 gpeoc99Cz1CVQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WD98w1p5Vz18f6;
	Tue,  2 Jul 2024 13:37:36 -0400 (EDT)
Message-ID: <d62eef15-f6c9-4299-b4ff-4b0d5631c35e@efficios.com>
Date: Tue, 2 Jul 2024 13:37:50 -0400
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 3/5] tracing: Allow user-space mapping of the
 ring-buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, "Dmitry V. Levin"
 <ldv@strace.io>, Vincent Donnefort <vdonnefort@google.com>,
 mhiramat@kernel.org, kernel-team@android.com, rdunlap@infradead.org,
 rppt@kernel.org, david@redhat.com, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240510140435.3550353-1-vdonnefort@google.com>
 <20240510140435.3550353-4-vdonnefort@google.com>
 <20240630105322.GA17573@altlinux.org>
 <20240630084053.0b506916@rorschach.local.home>
 <9a9c8ea4-8e17-4e7e-95fe-7b51441a228c@efficios.com>
 <20240702111807.13d2dd2c@rorschach.local.home>
 <cb02f5a0-d6a3-4228-9cbb-473fd392ee48@efficios.com>
 <20240702125126.50a6267c@rorschach.local.home>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240702125126.50a6267c@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-02 12:51, Steven Rostedt wrote:
> On Tue, 2 Jul 2024 11:32:53 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> If we use '*' for user events already, perhaps we'd want to consider
>> using the same range for the ring buffer ioctls ? Arguably one is
>> about instrumentation and the other is about ring buffer interaction
>> (data transport), but those are both related to tracing.
> 
> Yeah, but I still rather keep them separate.

No objection, I'm OK either way.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


