Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E0514C188
	for <lists+linux-api@lfdr.de>; Tue, 28 Jan 2020 21:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA1UTZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Jan 2020 15:19:25 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43609 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgA1UTZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Jan 2020 15:19:25 -0500
Received: by mail-il1-f195.google.com with SMTP id o13so11257392ilg.10
        for <linux-api@vger.kernel.org>; Tue, 28 Jan 2020 12:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qhAm7/HK5/TKnBe3PmGytSgj86Fd9BdncwboGoHpb9c=;
        b=F+FakNvq7g/3iR1a2Y2v8d5uRa65Cyb0xphZ7vqM0hDmR9lVLRCttgX4oPuSPjk7NZ
         ppo9CmUcWOPvn2N6hns9/GHnSZHu5QPgHHY/t9RSSJkGuOtgc4jVBzGgxQ7kU5X/XGin
         1czO7EP8HF+wd7KJ2DnzrmfI3xw5JPc71pfOkY+WrlLETqnQxtt4QpRJ+SN3aYWrmdEg
         HkKxwvlS3F/QfFCqGFB8ycfqTV53+Jl6ENwXHax1Qc3pm6MsPLJF3ANXepL/sl2PrVT3
         a3T8/rWROWbISF8SLSWWEK309bq7J6cW26Vb+0qzL46lttqhXYND0sgb3/lzKVg4faYA
         YKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qhAm7/HK5/TKnBe3PmGytSgj86Fd9BdncwboGoHpb9c=;
        b=rhW6QAIjubFmhvlwELqEaomBN3NSx0zCB95cXh4oOpJmp84rp+QNviojTPZURbMrjw
         KxdhcB8uBpPvLeo0KlzcuHwW5i6uFpqBQjZ50oSXv/Yku9+lR0svahTAGXPf2JVJ1NMo
         +Bo6FmnDimeVLIoLVQPLOTodX+EMUBqT3PbWAkwmBkYfi//+Oki7HruHb46yAS4RpZ18
         CIR7kt5plk7IA5icEmPEcyqDxEfxy2VlCKkYKAgcu/8OJHEQ6euRWBKug4HYm1OASV0j
         RvfwX09meJB1QGgjDNl6eGSw2EWVBLZdGgRS39vv09wlzsnQvm5R6j8vCZwZmhqen15Y
         2+QA==
X-Gm-Message-State: APjAAAXL49qlfCtIlnQfzH7+6Rh5Gcbn9SRN9BFza/AfzBzEIhegeMRi
        OEpbtdzY+58aBHPfwgzfIDHlO7r1AHo=
X-Google-Smtp-Source: APXvYqzl6S6cim2CtuL8pyACSM1cFa3i36N+HYh2pvz5297RzbzkOv5Clzc29/PAba99tng1LHnDiQ==
X-Received: by 2002:a92:5e8b:: with SMTP id f11mr21679563ilg.178.1580242764525;
        Tue, 28 Jan 2020 12:19:24 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a18sm6202500ilf.43.2020.01.28.12.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 12:19:24 -0800 (PST)
Subject: Re: IORING_REGISTER_CREDS[_UPDATE]() and credfd_create()?
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
 <15ca72fd-5750-db7c-2404-2dd4d53dd196@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82b20ec2-ceaa-93f1-4cce-889a933f2c7a@kernel.dk>
Date:   Tue, 28 Jan 2020 13:19:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <15ca72fd-5750-db7c-2404-2dd4d53dd196@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 1/28/20 1:16 PM, Pavel Begunkov wrote:
> On 28/01/2020 22:42, Jens Axboe wrote:
>> On 1/28/20 11:04 AM, Jens Axboe wrote:
>>> On 1/28/20 10:19 AM, Jens Axboe wrote:
>>>> On 1/28/20 9:19 AM, Jens Axboe wrote:
>>>>> On 1/28/20 9:17 AM, Stefan Metzmacher wrote:
>>>> OK, so here are two patches for testing:
>>>>
>>>> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.6/io_uring-vfs-creds
>>>>
>>>> #1 adds support for registering the personality of the invoking task,
>>>> and #2 adds support for IORING_OP_USE_CREDS. Right now it's limited to
>>>> just having one link, it doesn't support a chain of them.
>>>>
>>>> I'll try and write a test case for this just to see if it actually works,
>>>> so far it's totally untested. 
>>>>
>>>> Adding Pavel to the CC.
>>>
>>> Minor tweak to ensuring we do the right thing for async offload as well,
>>> and it tests fine for me. Test case is:
>>>
>>> - Run as root
>>> - Register personality for root
>>> - create root only file
>>> - check we can IORING_OP_OPENAT the file
>>> - switch to user id test
>>> - check we cannot IORING_OP_OPENAT the file
>>> - check that we can open the file with IORING_OP_USE_CREDS linked
>>
>> I didn't like it becoming a bit too complicated, both in terms of
>> implementation and use. And the fact that we'd have to jump through
>> hoops to make this work for a full chain.
>>
>> So I punted and just added sqe->personality and IOSQE_PERSONALITY.
>> This makes it way easier to use. Same branch:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.6/io_uring-vfs-creds
>>
>> I'd feel much better with this variant for 5.6.
>>
> 
> To be honest, sounds pretty dangerous. Especially since somebody started talking
> about stealing fds from a process, it could lead to a nasty loophole somehow.
> E.g. root registers its credentials, passes io_uring it to non-privileged
> children, and then some process steals the uring fd (though, it would need
> priviledged mode for code-injection or else). Could we Cc here someone really
> keen on security?

Link? If you can steal fds, then surely you've already lost any sense of
security in the first place? Besides, if root registered the ring, the root
credentials are already IN the ring. I don't see how this adds any extra
holes.

> Stefan, could you please explain, how this 5 syscalls pattern from the first
> email came in the first place? Just want to understand the case.

I think if you go back a bit in the archive, Stefan has a fuller explanation
of how samba does the credentials dance.

-- 
Jens Axboe

