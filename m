Return-Path: <linux-api+bounces-2559-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A7B9AEF21
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2024 20:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4AD8B20FF9
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2024 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090DF1FDFBF;
	Thu, 24 Oct 2024 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PY6bnvbh"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DD1F8920;
	Thu, 24 Oct 2024 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793019; cv=none; b=tNLBzHREkIZKGl87Y7BWpgd3o1TpIwEEudhOGlEthQmpinpLMR0CM83dusR+U2rrHdzxuKIBVoqNq50arVHM706g7TTOpfF2MjnTEm0LhynVJOKDRo04J6jBlK+Ju6DkZPwyZxe9xgciGV8G0UqBQLnwWOuv28AIgKa9x0sXJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793019; c=relaxed/simple;
	bh=sWnBAFH4IbZ5twYCv/cYtI8e+DH7Pqi8O7cDi1G+5NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/YHDY1nMtZlEGwFvgZJJnJlwILxDoXouZc1iBwLRg88/YJEO7RnaWANtGAtJvsyHGtIlrFIUC0MnrWvSPqWJ1f6fKYKG8lDlcmr0OcztlRVXKULLM9Z8QUr+bjb6E1ilnx/2ArdwUMpFB0pazbiRo/QD23Z4XWQHHasJz808d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PY6bnvbh; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CBd+GkIRbTunJ1PsOi2TROGNg+J3cxCD3fsCtMQSSiA=; b=PY6bnvbhEVwfiJrHxm04yghcgu
	1OsIiBZT0f0ASaTuK6r1+l3941zqIqmoujkLO3eHZkIRlPjekyTEN/DPMtF6GEiauhZlN0nDqiOEb
	ohuozgTq2mOhTgg/DRZRRq8jlY054OP80sIDKr7L3RFHziuWcMXWM+9/7AlDj6H2IQdAp9hQrBQ/9
	AYSrbZkqXilLwF6fo+NPvQggAecGtWDslYvkj/C8QM+i6hGrLlep9bor/K0GEE62KCFB/M0uPchbW
	fYaD9vyDRMls64Y4kC3Oy3tEvvn64ghoIhHX0kn5rOP+lhlb0Loplc/mim+5dnMubWCGbox5p9/e1
	wUBqEVeA==;
Received: from [177.172.124.83] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t42B4-00EbV0-9p; Thu, 24 Oct 2024 20:03:18 +0200
Message-ID: <1e62e083-f97c-4157-8d50-c3655edda97b@igalia.com>
Date: Thu, 24 Oct 2024 15:03:12 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/1] futex: Create set_robust_list2
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Darren Hart <dvhart@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, sonicadvance1@gmail.com,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 linux-api@vger.kernel.org
References: <20241024145735.162090-1-andrealmeid@igalia.com>
 <20241024145735.162090-2-andrealmeid@igalia.com>
 <bde852ec-8e2f-4957-9368-00d8e5a422c4@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <bde852ec-8e2f-4957-9368-00d8e5a422c4@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arnd,

Em 24/10/2024 12:57, Arnd Bergmann escreveu:
> On Thu, Oct 24, 2024, at 14:57, André Almeida wrote:
>> This new syscall allows to set multiple list to the same process. There
>> are two list types: 32 and 64 bit lists.
>>
>> It supports up to 10 lists per process (see ROBUST_LISTS_PER_TASK). The
>> lists are dynamically allocated on demand, as part of a linked list.
>> This is the proposed interface:
>>
>> 	long set_robust_list2(void *head, int index, unsigned int flags)
>>
>> Userspace can ask to set the head of a new list using (index = -1).
>> Kernel will allocate a new list, place in the linked list and return the
>> new index to userspace.
>>
>> Userspace can modify an existing head by using an index >= 0. If the
>> requested list doesn't exist, an error is returned.
>>
>> Userspace cannot remove a robust list.
>>
>> For now, flag is for the list type:
>>
>> 	enum robust_list_type {
>> 	 	ROBUST_LIST_32BIT,
>> 		ROBUST_LIST_64BIT,
>> 	 };
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> 
> Hi André,
> 
> I have no opinion on the syscall itself, but I'll comment on
> the way you hook it up:
> 
>>   arch/arm/tools/syscall.tbl             |  1 +
>>   arch/x86/entry/syscalls/syscall_64.tbl |  1 +
> 
> If we agree on the number, this should be added to all
> architectures at the same time. In particular, when
> you add it to 32-bit arm, it also needs to be in the
> corresponding arch/arm64/tools/syscall_32.tbl for
> compat mode.

Ok

> 
>>   include/uapi/asm-generic/unistd.h      |  5 +-
> 
> This reminds me that I need to send the patch to remove this
> file, nothing should use it any more, though we still have
> the copy in tools/include/uapi/asm-generic/unistd.h that
> still gets referenced until the scripts are changed to
> use the syscall.tbl format.
> 
>> +	if (unlikely(!list_empty(list2))) {
>> +		list_for_each_entry_safe(curr, n, list2, list) {
>> +			if (curr->head != NULL) {
>> +				if (curr->list_type == ROBUST_LIST_64BIT)
>> +					exit_robust_list(tsk, curr->head);
>> +				else if (curr->list_type == ROBUST_LIST_32BIT)
>> +					compat_exit_robust_list(tsk, curr->head);
>> +				curr->head = NULL;
>> +			}
> 
> This looks like the behavior of a 32-bit task using
> ROBUST_LIST_64BIT is different on native 32-bit kernels
> compared to running on compat mode.
> 
> Assuming we want them to behave the same way, did you intend
> ROBUST_LIST_64BIT to refer to 64-bit pointers on 32-bit
> tasks, or should they use normal word-size pointers?

Oh right, I haven't covered that indeed. I think I would need to have 
something like:

static void exit_robust_list_64()
static void exit_robust_list_32()

And then each function would use explicit sizes for pointers. Also, I 
would rewrite the conditions to make that every combination of 64/32bit 
kernel/app calls the appropriated function.

Alternatively, we could just disable 32bit kernel/app to use the 
ROBUST_LIST_64BIT option.

Thank you for your feedback!
	André

