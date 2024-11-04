Return-Path: <linux-api+bounces-2669-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD1B9BC065
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2024 22:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9DF1C20A73
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2024 21:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6A1D5CFF;
	Mon,  4 Nov 2024 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r33WZZ1/"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6714B94F;
	Mon,  4 Nov 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757365; cv=none; b=VzpsdbKBOWEnBERZz5swtyt+7J/RwgiuoZgocFIY+nILvtAhcFIfPBh3EhjrrrZxGqhnwqWvEZiLwAMATtoHlCk5d+DxHfDBKQQauGpqyTObGF5jUZlXkUgf5m5F0V5n+QdAJc8cw9eZoby5RdZq+ZCY2iDG4j/NebOHTvHq5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757365; c=relaxed/simple;
	bh=U31h+o74RVjMXL7/loS81By7bbydzhZWLyFk/1QFKGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSh8JUNzpaJnxEFeiaM/AS9iSAwLyloKtrZLbBpoQGhUmb+k2VdqMruRoWFVL2wHwAMrVfzmdtcqF9MXzvucTaU07PnHwNPOsr0o1rSngw9jfkSszoq6GuRwo3oTUL1pq9k1MPt2JIEWgqlN4mf/UT6g7y9ycYrFuOyiMVMb8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=r33WZZ1/; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GG1B6eb+FZfFk5uIGi3OTAWvgN8hYpzXzP7mahtmAJE=; b=r33WZZ1/ujRr8X41uraQfDTcBo
	v9fonMz2yopmUovf2zaAVNFfsNe6g+AfAL/mJdzmTMWqZwp1RgEQ0yWT2ezd+yPguHYCS3sUoK+EZ
	m1LySWRNNOliJCJE9/q0jVjozomlOLBVRwGxxXqcNSFSXZjjn4WE45qP4AKnyzWJufgDiQznXtr6P
	/d4pxc31tk5sceVQB4KkDy0gXs8VgDMXJIITpDGegoOgWAuCmr95hjSWqFYcEwntR1FCe+OmHLGR/
	Wz5dfdli4by5QGO1bEu6Gvmru+5626anNu4rbDQBXiDG361GHfX16pnDztHDtP/L32aE1oww6qUmb
	Pw0kgpqQ==;
Received: from [177.172.124.78] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t8538-001qw9-VN; Mon, 04 Nov 2024 22:55:51 +0100
Message-ID: <8373eb11-d61c-40c4-9289-1047ec35c4d6@igalia.com>
Date: Mon, 4 Nov 2024 18:55:45 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] futex: Create set_robust_list2
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>, sonicadvance1@gmail.com,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 linux-api@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
References: <20241101162147.284993-1-andrealmeid@igalia.com>
 <20241101162147.284993-3-andrealmeid@igalia.com>
 <20241104112240.GA24862@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241104112240.GA24862@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Peter,

Em 04/11/2024 08:22, Peter Zijlstra escreveu:
> On Fri, Nov 01, 2024 at 01:21:46PM -0300, André Almeida wrote:
>> @@ -1046,24 +1095,44 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
>>   
>>   static void futex_cleanup(struct task_struct *tsk)
>>   {
>> +	struct robust_list2_entry *curr, *n;
>> +	struct list_head *list2 = &tsk->robust_list2;
>> +
>>   #ifdef CONFIG_64BIT
>>   	if (unlikely(tsk->robust_list)) {
>> -		exit_robust_list64(tsk);
>> +		exit_robust_list64(tsk, tsk->robust_list);
>>   		tsk->robust_list = NULL;
>>   	}
>>   #else
>>   	if (unlikely(tsk->robust_list)) {
>> -		exit_robust_list32(tsk);
>> +		exit_robust_list32(tsk, (struct robust_list_head32 *) tsk->robust_list);
>>   		tsk->robust_list = NULL;
>>   	}
>>   #endif
>>   
>>   #ifdef CONFIG_COMPAT
>>   	if (unlikely(tsk->compat_robust_list)) {
>> -		exit_robust_list32(tsk);
>> +		exit_robust_list32(tsk, tsk->compat_robust_list);
>>   		tsk->compat_robust_list = NULL;
>>   	}
>>   #endif
>> +	/*
>> +	 * Walk through the linked list, parsing robust lists and freeing the
>> +	 * allocated lists
>> +	 */
>> +	if (unlikely(!list_empty(list2))) {
>> +		list_for_each_entry_safe(curr, n, list2, list) {
>> +			if (curr->head != NULL) {
>> +				if (curr->list_type == ROBUST_LIST_64BIT)
>> +					exit_robust_list64(tsk, curr->head);
>> +				else if (curr->list_type == ROBUST_LIST_32BIT)
>> +					exit_robust_list32(tsk, curr->head);
>> +				curr->head = NULL;
>> +			}
>> +			list_del_init(&curr->list);
>> +			kfree(curr);
>> +		}
>> +	}
>>   
>>   	if (unlikely(!list_empty(&tsk->pi_state_list)))
>>   		exit_pi_state_list(tsk);
> 
> I'm still digesting this, but the above seems particularly silly.
> 
> Should not the legacy lists also be on the list of lists? I mean, it
> makes no sense to have two completely separate means of tracking lists.
> 

You are asking if, whenever someone calls set_robust_list() or 
compat_set_robust_list() to be inserted into &current->robust_list2 
instead of using tsk->robust_list and tsk->compat_robust_list?

I was thinking of doing that, but my current implementation has a 
kmalloc() call for every insertion, and I wasn't sure if I could add 
this new latency to the old set_robust_list() syscall. Assuming it is 
usually called just once during the thread initialization perhaps it 
shouldn't cause much harm I guess.


