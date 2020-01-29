Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9255C14C3E1
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 01:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgA2ASu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Jan 2020 19:18:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43293 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgA2ASu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Jan 2020 19:18:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id u131so7885037pgc.10
        for <linux-api@vger.kernel.org>; Tue, 28 Jan 2020 16:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xu0t7fQFOPxeBK58JhveLHReraKm9bUYSb0AKFkvn/Y=;
        b=ecLBFq3oczw0ffuQm/J+InSnKBAUPAv8869Xc/2a5qLYe2jSwpwbmYj8nsV0a71Twt
         IZ11Fmx0g0xz+57FSlOy6uL+anS82lUJGOY/XY+ipXTVS5CQCJslLiT+KAGBV49v1ljA
         WAEMKPJGTP1AAsode9vw1OreOTu0I9U+GtABSYXOcINnewILjNmOZ9HE4ilhOzjOGpo3
         4oigRdjVVnD1mjX+LsHGoU7PFMEoB/5JpS4ioJAaTVXPokn7uB2qCq5mYxnle7wNczMj
         vJzNL4Wh/+1fHsniRl+PCPVieU4/76817w3o+DbymJsbI9j7Qfv5TwWSLiMtJ4xH8hgD
         0YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xu0t7fQFOPxeBK58JhveLHReraKm9bUYSb0AKFkvn/Y=;
        b=spgKBLk51wwE/F/CKXxOQ4tvxY8VIHDPsg4Bib2QbBo7Xp4IZ7bW3/YUN9GlVsD4MS
         MYHEuMO+HDYvAJ6j8ZPzn/qZf3mApYg7OBAyzx9qnNXYuEgHNA0Qw8PgOatpZX+aT770
         zHtWiI9B/3faUmCilqLWbsi44/U50/n6xn2lXSSevxK1dGAIsKZ2EOMjQ4RT5e9ddwBa
         QLIfFP/4V3D1Phn8C9XmMzWOqm9WWXhtznTgJDvYZBsGU46hyzLcCzcoiKBgcJ2CqVcs
         hIYWKOKyAWLLw7QD/HucsIOSVlizGnN9TV5G/OlaPlEp4eMM4WrgWfbmgzN+X8bJgtsw
         Sl/Q==
X-Gm-Message-State: APjAAAVMI6a/RlH40SD0829R0KGvnlW8vlGacrs6iW2ZJsJxyAPK6rY8
        r6sUUVFagy7NwMnP8nM+oL+QKkDh6HY=
X-Google-Smtp-Source: APXvYqxHgZkaGIBKVJrxFT0ryGUAAWh3XtK5Z4Ea5Gq9qWbw+MPmRwZ92FhWTJR8CtwbF0WMNB+66w==
X-Received: by 2002:a63:5f84:: with SMTP id t126mr26845132pgb.71.1580257129418;
        Tue, 28 Jan 2020 16:18:49 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y2sm184158pff.139.2020.01.28.16.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 16:18:49 -0800 (PST)
Subject: Re: IORING_REGISTER_CREDS[_UPDATE]() and credfd_create()?
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Metzmacher <metze@samba.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>
References: <ea9f2f27-e9fe-7016-5d5f-56fe1fdfc7a9@samba.org>
 <d6bc8139-abbe-8a8d-7da1-4eeafd9eebe7@kernel.dk>
 <688e187a-75dd-89d9-921c-67de228605ce@samba.org>
 <b29e972e-5ca0-8b5f-46b3-36f93d865723@kernel.dk>
 <1ac31828-e915-6180-cdb4-36685442ea75@kernel.dk>
 <0d4f43d8-a0c4-920b-5b8f-127c1c5a3fad@kernel.dk>
 <b88f0590-71c9-d2bd-9d17-027b05d30d7a@kernel.dk>
 <2d7e7fa2-e725-8beb-90b9-6476d48bdb33@gmail.com>
 <6c401e23-de7c-1fc1-4122-33d53fcf9700@kernel.dk>
 <35eebae7-76dd-52ee-58b2-4f9e85caee40@kernel.dk>
 <d3f9c1a4-8b28-3cfe-de88-503837a143bc@gmail.com>
 <6415ae98-e205-5374-296d-0442e1ed2034@kernel.dk>
Message-ID: <a54d66b8-6c50-7a34-1e9e-5954c4ccd3e8@kernel.dk>
Date:   Tue, 28 Jan 2020 17:18:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6415ae98-e205-5374-296d-0442e1ed2034@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 1/28/20 5:15 PM, Jens Axboe wrote:
> On 1/28/20 5:10 PM, Pavel Begunkov wrote:
>> On 29/01/2020 02:51, Jens Axboe wrote:
>>> On 1/28/20 4:40 PM, Jens Axboe wrote:
>>>> On 1/28/20 4:36 PM, Pavel Begunkov wrote:
>>>>> On 28/01/2020 22:42, Jens Axboe wrote:
>>>>>> I didn't like it becoming a bit too complicated, both in terms of
>>>>>> implementation and use. And the fact that we'd have to jump through
>>>>>> hoops to make this work for a full chain.
>>>>>>
>>>>>> So I punted and just added sqe->personality and IOSQE_PERSONALITY.
>>>>>> This makes it way easier to use. Same branch:
>>>>>>
>>>>>> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.6/io_uring-vfs-creds
>>>>>>
>>>>>> I'd feel much better with this variant for 5.6.
>>>>>>
>>>>>
>>>>> Checked out ("don't use static creds/mm assignments")
>>>>>
>>>>> 1. do we miscount cred refs? We grab one in get_current_cred() for each async
>>>>> request, but if (worker->creds != work->creds) it will never be put.
>>>>
>>>> Yeah I think you're right, that needs a bit of fixing up.
>>>
>>
>> Hmm, it seems it leaks it unconditionally, as it grabs in a ref in
>> override_creds().
>>
>>> I think this may have gotten fixed with the later addition posted today?
>>> I'll double check. But for the newer stuff, we put it for both cases
>>> when the request is freed.
>>
>> Yeah, maybe. I got tangled trying to verify both at once and decided to start
>> with the old one.
>>
>>
>>>>> 2. shouldn't worker->creds be named {old,saved,etc}_creds? It's set as
>>>>>
>>>>>     worker->creds = override_creds(work->creds);
>>>>>
>>>>> Where override_creds() returns previous creds. And if so, then the following
>>>>> fast check looks strange:
>>>>>
>>>>>     worker->creds != work->creds
>>>>
>>>> Don't care too much about the naming, but the logic does appear off.
>>>> I'll take a look at both of these tonight, unless you beat me to it.
>>
>> Apparently, you're faster :)
>>
>>>
>>> Testing this now, what a braino.
>>>
>>> diff --git a/fs/io-wq.c b/fs/io-wq.c
>>> index ee49e8852d39..8fbbadf04cc3 100644
>>> --- a/fs/io-wq.c
>>> +++ b/fs/io-wq.c
>>> @@ -56,7 +56,8 @@ struct io_worker {
>>>  
>>>  	struct rcu_head rcu;
>>>  	struct mm_struct *mm;
>>> -	const struct cred *creds;
>>> +	const struct cred *cur_creds;
>>> +	const struct cred *saved_creds;
>>>  	struct files_struct *restore_files;
>>>  };
>>>  
>>> @@ -135,9 +136,9 @@ static bool __io_worker_unuse(struct io_wqe *wqe, struct io_worker *worker)
>>>  {
>>>  	bool dropped_lock = false;
>>>  
>>> -	if (worker->creds) {
>>> -		revert_creds(worker->creds);
>>> -		worker->creds = NULL;
>>> +	if (worker->saved_creds) {
>>> +		revert_creds(worker->saved_creds);
>>> +		worker->cur_creds = worker->saved_creds = NULL;
>>>  	}
>>>  
>>>  	if (current->files != worker->restore_files) {
>>> @@ -424,10 +425,11 @@ static void io_wq_switch_mm(struct io_worker *worker, struct io_wq_work *work)
>>>  static void io_wq_switch_creds(struct io_worker *worker,
>>>  			       struct io_wq_work *work)
>>>  {
>>> -	if (worker->creds)
>>> -		revert_creds(worker->creds);
>>> +	if (worker->saved_creds)
>>> +		revert_creds(worker->saved_creds);
>>>  
>>> -	worker->creds = override_creds(work->creds);
>>> +	worker->saved_creds = override_creds(work->creds);
>>> +	worker->cur_creds = work->creds;
>>>  }
>>
>> How about as follows? rever_creds() is a bit heavier than put_creds().
>>
>> static void io_wq_switch_creds(struct io_worker *worker,
>> 			       struct io_wq_work *work)
>> {
>> 	const struct cred *old_creds = override_creds(work->creds);
>>
>> 	if (worker->saved_creds)
>> 		put_cred(old_creds);
>> 	else
>> 		worker->saved_creds = old;
>> 	worker->cur_creds = work->creds;
>> }
> 
> Looks good to me, I'll fold.

Actually, it doesn't clear current->cred then, which seems a bit..
unfortunate. Could be a source of issues.

-- 
Jens Axboe

