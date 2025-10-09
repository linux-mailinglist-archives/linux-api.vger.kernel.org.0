Return-Path: <linux-api+bounces-5044-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C5BBC9D17
	for <lists+linux-api@lfdr.de>; Thu, 09 Oct 2025 17:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494973A1185
	for <lists+linux-api@lfdr.de>; Thu,  9 Oct 2025 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A51F2382;
	Thu,  9 Oct 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QqWq1/bD"
X-Original-To: linux-api@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4821F63CD
	for <linux-api@vger.kernel.org>; Thu,  9 Oct 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024122; cv=none; b=ORX+4lTa/sIwAA6Gd7oHzxMq0fOJZFaqIxd6nx/zb75f2+lXLMFyKnWvCzAjQRTQRqPuK1WHwmsb99Jj5cioI4uGFzZZ8SS7qOpnUuBhFD9pxE1pOignl9ncwCqxIXiqfyCB0jbsZC4CejrdinN+dQPSXoE6otyjvRXoQMhaFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024122; c=relaxed/simple;
	bh=J8ZJUImhVak4NCWBEBOWPN6kWYQrYPxXHx1ktL3bl30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKbp+BdcgeAC65UFuVNZv1oRZ/+WlAkqPKR+Ah6eK8Nm8iRvgzPUwqew69ISiQ4WMPv4V2Yf39IwlA6UUjpZkX9MDYTGFIIpUEamZSuKSsyi/0FJwHZMyAdx+RXVAI7ypYktiPbHV8e480jAtoWX2m/qMI7omplZSNmm/30PVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QqWq1/bD; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc71808c-c6a4-434a-aee9-b97601814c92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760024108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yFgQ+7gYZsvROerfNe0yh1z4oSCTjP80VqQTNRlYmQE=;
	b=QqWq1/bDCQ9wrcuY1e4iXNgAoOLqxLWvI/2t1eY4xJDbCp7+DH9xa/5TFEjwt5ubuVgWgJ
	MGhj34pZv8qeKmjQKwN2cQNbV1e4c2EUQfGpdEf9KG6vXuv1Bxy1j2IIAxxpkXwWURmbXD
	sXd3/hCh+JpQpcRffrQU8OvwFU18vsI=
Date: Thu, 9 Oct 2025 08:34:50 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state
 monitoring
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
 rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
 masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
 yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
 chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
 jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
 dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org,
 rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org,
 zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com,
 Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
 aleksander.lobakin@intel.com, ira.weiny@intel.com,
 andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
 bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
 stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
 ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
 leonro@nvidia.com, witu@nvidia.com
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-20-pasha.tatashin@soleen.com>
 <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
 <mafs0qzvcmje2.fsf@kernel.org>
 <CA+CK2bCx=kTVORq9dRE2h3Z4QQ-ggxanY2tDPRy13_ARhc+TqA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CA+CK2bCx=kTVORq9dRE2h3Z4QQ-ggxanY2tDPRy13_ARhc+TqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/10/9 5:01, Pasha Tatashin 写道:
>>> Because the window of kernel live update is short, it is difficult to statistics
>>> how many times the kernel is live updated.
>>>
>>> Is it possible to add a variable to statistics the times that the kernel is live
>>> updated?
>> The kernel doesn't do the live update on its own. The process is driven
>> and sequenced by userspace. So if you want to keep statistics, you
>> should do it from your userspace (luod maybe?). I don't see any need for
>> this in the kernel.
>>
> One use case I can think of is including information in kdump or the
> backtrace warning/panic messages about how many times this machine has
> been live-updated. In the past, I've seen bugs (related to memory
> corruption) that occurred only after several kexecs, not on the first
> one. With live updates, especially while the code is being stabilized,
> I imagine we might have a similar situation. For that reason, it could
> be useful to have a count in the dmesg logs showing how many times
> this machine has been live-updated. While this information is also
> available in userspace, it would be simpler for kernel developers
> triaging these issues if everything were in one place.
I’m considering this issue from a system security perspective. After the 
kernel is automatically updated, user-space applications are usually 
unaware of the change. In one possible scenario, an attacker could 
replace the kernel with a compromised version, while user-space 
applications remain unaware of it — which poses a potential security risk.

To mitigate this, it would be useful to expose the number of kernel 
updates through a sysfs interface, so that we can detect whether the 
kernel has been updated and then collect information about the new 
kernel to check for possible security issues.

Of course, there are other ways to detect kernel updates — for example, 
by using ftrace to monitor functions involved in live kernel updates — 
but such approaches tend to have a higher performance overhead. In 
contrast, adding a simple update counter to track live kernel updates 
would provide similar monitoring capability with minimal overhead.

Yanjun.Zhu

>
> Pasha

-- 
Best Regards,
Yanjun.Zhu


