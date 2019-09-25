Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A784EBDFFE
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 16:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437094AbfIYOaB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 10:30:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37841 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437087AbfIYOaB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 10:30:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so5228834wmc.2;
        Wed, 25 Sep 2019 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rHX/ur7cCMPcfNJyelmVApXQMGAEU/oOAeQWFzD3xRQ=;
        b=Jt3fpjUo2rJ9SM5erC/Hv26iH+wvWmTwxNt/LIvZJgjSQiZUK2fkCr5e0Ey3cFvBVz
         //SnbocygEF7cZ8XL/HABZn5BV2vo/9HTBUgWHntfO9o/IWa1B3ZpCyHhMv/3oY1I/HD
         KEFDJq5dwC7VrK4PWdTYTRlCPzf36migTvh6kawtTeoGXQ2ZfwKLZ2tnD/vvGXODW7mW
         JvafIdjt7CkyX3uizAV0EATzOS07pUfH84Iggg0cWR5Y4M94qlcewa4ni7LaiTsAVUqc
         Sxq2nCWcgWbSUOLZ4CTPF40bbB2d4sU4VoKmpd3zRSBD7Hsq9BmEyMGFEXAbE/6YfwlF
         UeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rHX/ur7cCMPcfNJyelmVApXQMGAEU/oOAeQWFzD3xRQ=;
        b=kXNEywU0/Bord7K7dy8aFcJ7yb5XRIE2f5RcQ/U0OGdI45/CX3B5Gd2zXLqTzyG8Na
         d1SZI+a4qdw0McnKL13ujx64JzWejqFTpw7d4c/2d/1CGdJS/Fch6sVEglBwU5g0JY57
         vxi0gB1inp4wQWYJHIYyeEXD7TCYqJ0y4iGzIM/y8fGH5n9+N0rC+RTV5jOoX44T5N2V
         UjF/woURwcowIE+L6iqcGl5SRZpEaDz/sbI3hztm5ZmFS3rJ66uQUp02TXG2XW1FNQni
         LV/NKMQrljtN0iB04IUgM/SExlU/ms1BNxqx5LkHebrhFsM0MAf8duewVpKjsG8ILC1h
         V18g==
X-Gm-Message-State: APjAAAWU/TULx7iLWVlrvMlPhUz80Q7cGYDCG727SOydIrjxYZnwtv0A
        TT68luVgLBo13lddrGUzIRe106CW
X-Google-Smtp-Source: APXvYqxxNUHkNWhgaX1+X8cYZgP+kRS6Ov4k4YAwW/TS93oC6n+S/KllUPhJfRn4cEjECg68ER0KCw==
X-Received: by 2002:a1c:bcd6:: with SMTP id m205mr7822091wmf.129.1569421798223;
        Wed, 25 Sep 2019 07:29:58 -0700 (PDT)
Received: from [10.0.20.253] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id a10sm6632323wrv.64.2019.09.25.07.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 07:29:56 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Florian Weimer <fw@deneb.enyo.de>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: For review: pidfd_send_signal(2) manual page
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87pnjr9rth.fsf@mid.deneb.enyo.de>
 <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
 <90dd38d5-34b3-b72f-8e5a-b51f944f22fb@gmail.com>
 <20190924195701.7pw2olbviieqsg5q@wittgenstein>
 <b76adb4c-826b-6493-ba75-a9863066d3b1@gmail.com>
 <20190924215316.gxev2anuqffegocw@wittgenstein>
 <331cc245-3f70-dd43-31f9-8c1680ca6b20@gmail.com>
 <20190925135308.rev5tczcigyuchae@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <1d413e4b-30a6-9ab5-546d-a4db95b4b6eb@gmail.com>
Date:   Wed, 25 Sep 2019 16:29:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190925135308.rev5tczcigyuchae@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Christian,

On 9/25/19 3:53 PM, Christian Brauner wrote:
> On Wed, Sep 25, 2019 at 03:46:26PM +0200, Michael Kerrisk (man-pages) wrote:
>> On 9/24/19 11:53 PM, Christian Brauner wrote:
>>> On Tue, Sep 24, 2019 at 11:00:03PM +0200, Michael Kerrisk (man-pages) wrote:
>>>> Hello Christian,
>>>>
>>>>>>> If you're the parent of the process you can do this without CLONE_PIDFD:
>>>>>>> pid = fork();
>>>>>>> pidfd = pidfd_open();
>>>>>>> ret = pidfd_send_signal(pidfd, 0, NULL, 0);
>>>>>>> if (ret < 0 && errno == ESRCH)
>>>>>>> 	/* pidfd refers to another, recycled process */
>>>>>>
>>>>>> Although there is still the race between the fork() and the
>>>>>> pidfd_open(), right?
>>>>>
>>>>> Actually no and my code is even too complex.
>>>>> If you are the parent, and this is really a sequence that obeys the
>>>>> ordering pidfd_open() before waiting:
>>>>>
>>>>> pid = fork();
>>>>> if (pid == 0)
>>>>> 	exit(EXIT_SUCCESS);
>>>>> pidfd = pidfd_open(pid, 0);
>>>>> waitid(pid, ...);
>>>>>
>>>>> Then you are guaranteed that pidfd will refer to pid. No recycling can
>>>>> happen since the process has not been waited upon yet (That is,
>>>>
>>>> D'oh! Yes, of course. 
>>>>
>>>>> excluding special cases such as where you have a mainloop where a
>>>>> callback reacts to a SIGCHLD event and waits on the child behind your
>>>>> back and your next callback in the mainloop calls pidfd_open() while the
>>>>> pid has been recycled etc.).
>>>>> A race could only appear in sequences where waiting happens before
>>>>> pidfd_open():
>>>>>
>>>>> pid = fork();
>>>>> if (pid == 0)
>>>>> 	exit(EXIT_SUCCESS);
>>>>> waitid(pid, ...);
>>>>> pidfd = pidfd_open(pid, 0);
>>>>>
>>>>> which honestly simply doesn't make any sense. So if you're the parent
>>>>> and you combine fork() + pidfd_open() correctly things should be fine
>>>>> without even having to verify via pidfd_send_signal() (I missed that in
>>>>> my first mail.).
>>>>
>>>> Thanks for the additional detail.
>>>
>>> You're very welcome.
>>>
>>>>
>>>> I added the following to the pidfd_open() page, to
>>>> prevent people making the same thinko as me:
>>>>
>>>>        The following code sequence can be used to obtain a file  descrip‐
>>>>        tor for the child of fork(2):
>>>>
>>>>            pid = fork();
>>>>            if (pid > 0) {     /* If parent */
>>>>                pidfd = pidfd_open(pid, 0);
>>>>                ...
>>>>            }
>>>>
>>>>        Even  if  the  child process has already terminated by the time of
>>>>        the pidfd_open() call, the returned file descriptor is  guaranteed
>>>>        to refer to the child because the parent has not yet waited on the
>>>>        child (and therefore, the child's ID has not been recycled).
>>>
>>> Thanks! I'm fine with the example. The code illustrates the basics. If
>>> you want to go overboard, you can mention my callback example and put my
>>> SIG_IGN code snippet from my earlier mails (cf. [1] and [2]) in there.
>>> But imho, that'll complicate the manpage and I'm not sure it's worth it.
>>
>> I agree that we should not complicate this discussion with more code,
>> but how about we refine the text as follows:
>>
>>        The following code sequence can be used to obtain a file  descrip‐
>>        tor for the child of fork(2):
>>
>>            pid = fork();
>>            if (pid > 0) {     /* If parent */
>>                pidfd = pidfd_open(pid, 0);
>>                ...
>>            }
>>
>>        Even  if  the  child  has  already  terminated  by the time of the
>>        pidfd_open() call, its PID will not have  been  recycled  and  the
>>        returned  file  descriptor  will  refer  to  the  resulting zombie
>>        process.  Note, however, that this is guaranteed only if the  fol‐
>>        lowing conditions hold true:
>>
>>        *  the  disposition  of  SIGCHLD  has  not  been explicitly set to
>>           SIG_IGN (see sigaction(2)); and
> 
> Ugh, I forgot a third one. There's also SA_NOCLDWAIT. When set and
> the SIGCHLD handler is set to SIG_DFL then no zombie processes are
> created and no SIGCHLD signal is sent. When an explicit handler for
> SIGCHLD is set then a SIGCHLD signal is generated but the process will
> still not be turned into a zombie...

Oh, yes. I added:

       *  the SA_NOCLDSTOP flag was not specified  while  establishing  a
          handler  for  SIGCHLD  or while setting the disposition of that
          signal to SIG_DFL (see sigaction(2));

>>        *  the zombie process was not  reaped  elsewhere  in  the  program
>>           (e.g.,  either  by an asynchronously executed signal handler or
>>           by wait(2) or similar in another thread).
>>
>>        If these conditions don't hold true, then the child process should
> 
> "If any of these conditions does not hold, the child process..."
> 
> That might be clearer. But I leave the call on that to you. :)

Yep, your wording is better. Fixed.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
