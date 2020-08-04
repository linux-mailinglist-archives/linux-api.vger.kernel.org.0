Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A9823C077
	for <lists+linux-api@lfdr.de>; Tue,  4 Aug 2020 22:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHDUEW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Aug 2020 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgHDUEV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Aug 2020 16:04:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59350C06174A;
        Tue,  4 Aug 2020 13:04:21 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g8so3780820wmk.3;
        Tue, 04 Aug 2020 13:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z2vR9mbW2WGuKToLgembDnAlnOKrvrY4I1IvKrW5yHM=;
        b=COTRw/30XcvY8dsrfNO1B5k9TMGZAXxjXnP6rKByR6NyxhKyjir5K2tqrwDSOXz8OD
         Q3cpvnuzC/tWfxcGcA4xdcgKX+7OmqKW28S2wF9+z3rYxdFPsqSRjPJX/wn21pokbNWM
         kqlJiNXMVy8rZ4OEVU45EJkLvsD5Ekyr0dzKr7Sapo8fcezhuqjIOaasgqZj4xnbwDUx
         CrFfdvQ9h+WMg230sy0/kQx8XutVZGzr7s3ux4vgE+HFcDyUwrPhzJ1Y5muGIiQ4cfIO
         aglZWEFK3ZgStGf12qSfqPkYo+plflmGZ1/xlcHKyPb0fbOGfMNrVXkt3OGS7KBQa0fq
         OtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z2vR9mbW2WGuKToLgembDnAlnOKrvrY4I1IvKrW5yHM=;
        b=qqCHIsci6aYPPLBXDAi858ocpCMrVgaDDaTxMw/nJRxhwHYhhp6mjIJmuJ/CMb5R7Y
         yQhjnLTdc6S6u7vi3U7iWXtepKqJEnIIN5tbiR724xE4jEK/lZAAZviv9C9q04dpvCRy
         g9+2JkGZ4qEoLtk1w555Qw4NrA9JAHnoY02matq0w0lyh54ZW5CH+lAHWHJwSSEN2P9B
         SsHf9kwPNxLTJCWKB5ZKwfFzNuhptgllmJjBk8U2CWOW9I3K9xvqmXl9oUhmqV5QVTSM
         4qprtdpoHAMUJ7Tq7YPCy+ENtryZTZLFdxOb8M93pYpVDxzrf/b3coBAZQ03WAV/o1TF
         d9iQ==
X-Gm-Message-State: AOAM532qHr2pZT+DkAk7aWb1cmvau41oGd4CHlyo2Y3QW4k3YF5KNZ1s
        V/mBkep0+ZZKsIO/lqGh9G2G0mu9
X-Google-Smtp-Source: ABdhPJyLdMViH8MP8NG3KIsM1Pc/5pyaenMXCzGx0UU2Bfe3AoReMhSidx8tYImOMt6VhV6EbKer6A==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr83550wmb.75.1596571459680;
        Tue, 04 Aug 2020 13:04:19 -0700 (PDT)
Received: from ?IPv6:2001:a61:241a:1101:8c63:f991:aa91:da82? ([2001:a61:241a:1101:8c63:f991:aa91:da82])
        by smtp.gmail.com with ESMTPSA id p8sm33783277wrq.9.2020.08.04.13.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 13:04:18 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>,
        Zack Weinberg <zackw@panix.com>,
        Florian Weimer <fweimer@redhat.com>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH] Replacing "master-slave" terminology for
 pseudoterminals
To:     enh <enh@google.com>
References: <b3b4cf95-5eaa-0b4e-34cc-1a855e7148b6@gmail.com>
 <88273c2f-ce21-db54-688d-5bebd4a81ecd@redhat.com>
 <cbf7666c-440e-b4bd-0ff6-712123845fae@gmail.com>
 <c690ad2f-5f3c-5a8b-7b4c-ad29976aeab0@redhat.com>
 <CAJgzZoqR4Vh0phZjrDB9dgxNPzH0a35YjC1CwKb3mREOFn5Kbg@mail.gmail.com>
 <c756202e-7af8-c1b4-e99f-d77f3eae8c09@gmail.com>
 <CAJgzZoqFvn649xG5XSNBmUutgGQ8b16ELhVsdf0XD0QwFrRtZw@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <bf5bf287-c44a-dec5-211d-772d1a70b5b3@gmail.com>
Date:   Tue, 4 Aug 2020 22:04:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJgzZoqFvn649xG5XSNBmUutgGQ8b16ELhVsdf0XD0QwFrRtZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/4/20 7:25 PM, enh wrote:
> On Fri, Jul 31, 2020 at 12:48 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>
>> Hi Elliot,
>>
>> On 7/30/20 10:35 PM, enh wrote:
>>> On Thu, Jul 30, 2020 at 4:38 AM Carlos O'Donell <carlos@redhat.com> wrote:
>>>>
>>>> On 7/30/20 5:16 AM, Michael Kerrisk (man-pages) wrote:
>>>>> I know what you mean. One reason for that verbosity is the need to
>>>>> clearly distinguish "pseudoterminal device/end" from "pseudoterminal
>>>>> device pair". It's hard to avoid being wordy there.
>>>>
>>>> The perfect is the enemy of the good. My feeling is that as others
>>>> write this text in emails or discussions, we'll eventually all settle
>>>> on some other short form we find agreeable and then later we can adjust
>>>> the man pages to use that.
>>>
>>> based on my own brief experience, i'm expecting that _code_ will
>>> settle on pty and tty. but if you're reading the man pages to
>>> understand the concepts -- which are inherently quite confusing -- i
>>> think spelling things out in longhand might remain useful in that
>>> context.
>>>
>>>> Until then taking the lead to change this
>>>> language is the correct way forward.
>>>
>>> yeah, definitely.
>>>
>>> i'd prefer for michael to go first -- since the bionic documentation
>>> is basically just a link to man7.org, and even without that he's the
>>> canonical source -- but i'm happy to go first and submit my change
>>> first if it helps us make progress :-)
>>
>> I'd prefer to take this a little slowly. I don't plan to merge the
>> changes just yet. I'm interested to get a bit more feedback first,
>> including from Zack. (I'm guessing Zack is on holiday or so, which
>> is why we've not heard from him.) Also, if we have rough consensus
>> on this change, I would like to raise it with the POSIX folk; it
>> would of course be great if there was a corresponding change in the
>> standard, so that we all (all UNIX) have a common set of reference
>> terms.
> 
> the good news is that it came up at this week's austin group meeting...

Yes, I (also) noticed in the Austin group minutes.

> the bad news is that (afaik) none of us were there.
> 
> i had been planning to suggest we try to join next week anyway, to
> avoid having this stall again.

I suggest that we lay the groundwork with an email. I've started
crafting a mail to the POSIX folk that will CC all of the parties
to the discussion we have already been having, and pointing at the
current proposal. I'll send it out tomorrow morning. 

One complication in trying to have this discussion on mailing lists
is that the Austin list can only be  posted to by subscribers :-(.)
If you want to participate in the discussion, it may be best to join
the Austin Group mailing list (which essentially means joining the
Austin Group), if you are not already a member. I think you can 
find the steps to do so here:

https://www.opengroup.org/austin/lists.html

If you don't do this, your mails to the austin-group-l@opengroup.org
list will be rejected.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
