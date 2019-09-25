Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74F1FBDF5A
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406832AbfIYNqP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 09:46:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51934 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406650AbfIYNqP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 09:46:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so5752566wme.1;
        Wed, 25 Sep 2019 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1/Kc/2vwe/MWcIEq574opB9VZ0KeBd39iKMn9f9wOnM=;
        b=JTomjbEBqTVk6AiQ4QAg9u178HwdzgYAqM06AEjKwVdIirhgf52VyLgl0dnyFPEEZs
         dy+iTYnHtUzqFKXS8tOozAsXIcmuzmIMsC3mMjkDwk071DKfh5YSg/ApOyVgn0Zpv/Df
         eW7l9z36yVJJIWmWrytRY1txFkotV44p3wHyRggeLdBZ5aQS+Doze8flgwCvqn4/iLIh
         b0qac38/MnVTwrazUjChDAze3H+TvMrH55eMXHhCJdbSIcFFi8/QKp4pdA/VYBV+PJqb
         ukiJ4zInkzp2VuS8dus88BRWRzGb5g8UTV6jPMHrRs2GQbxOPtXwgrwtsolotkbbTwP9
         1CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1/Kc/2vwe/MWcIEq574opB9VZ0KeBd39iKMn9f9wOnM=;
        b=Ky9xhSORIXML/12WlyWt1EpWSkUXxvT158IdJphF1TUT+SxLqXAlIWVtSeP5gQPA/w
         UIwheCjaJl2r8vXEd6gVxB35FBLCzaTiezQt6Rq5GsiuVh23oT0y0CNCP77lCvXdxMYo
         AY0ftOc56wni11mkI6OM6jk+/2Pic8HuJPQG7VckmcnqWfWhe7L80Nsz++TNvCJ9ZXhw
         xUUNbipfTJyy6eson7l8VAVckdlnJuXPd2+kwUQwpmm8O23740aGqo4CPd5hrU8bKkeV
         RMHFQBKU0nr6F79+ADz1pv11xJxrPK5g1c1sA0Iy4BKiBS7/SbZVNJ8MNIwf7rj0hR2C
         Wryw==
X-Gm-Message-State: APjAAAUVrdNA10gMnOibjKtMAgDmbyL6AehIQ3mbdhtgEifIvQ1Xf2qX
        LAXzHoIaykKNINVG+84aB9z0EhZN
X-Google-Smtp-Source: APXvYqzQh/XqU5mG5shn/4vH4eQCrwKReSEMGtlCyAcUO3EellvdrN56+ANHLNuu2keFF4xj/UDg5Q==
X-Received: by 2002:a1c:d183:: with SMTP id i125mr8322398wmg.1.1569419172234;
        Wed, 25 Sep 2019 06:46:12 -0700 (PDT)
Received: from [10.0.20.253] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id w125sm6650515wmg.32.2019.09.25.06.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 06:46:10 -0700 (PDT)
Cc:     mtk.manpages@gmail.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: For review: pidfd_send_signal(2) manual page
To:     Daniel Colascione <dancol@google.com>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87pnjr9rth.fsf@mid.deneb.enyo.de>
 <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
 <90dd38d5-34b3-b72f-8e5a-b51f944f22fb@gmail.com>
 <20190924195701.7pw2olbviieqsg5q@wittgenstein>
 <b76adb4c-826b-6493-ba75-a9863066d3b1@gmail.com>
 <CAKOZueuJ=En9=mtFvhpmsnjqMAOjVmffaVwwzpe=ieHemxH3mw@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <b2519fb3-8bf5-d821-ae48-dad4435330f4@gmail.com>
Date:   Wed, 25 Sep 2019 15:46:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKOZueuJ=En9=mtFvhpmsnjqMAOjVmffaVwwzpe=ieHemxH3mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Daniel,

On 9/24/19 11:08 PM, Daniel Colascione wrote:
> On Tue, Sep 24, 2019 at 2:00 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>
>> Hello Christian,
>>
>>>>> If you're the parent of the process you can do this without CLONE_PIDFD:
>>>>> pid = fork();
>>>>> pidfd = pidfd_open();
>>>>> ret = pidfd_send_signal(pidfd, 0, NULL, 0);
>>>>> if (ret < 0 && errno == ESRCH)
>>>>>     /* pidfd refers to another, recycled process */
>>>>
>>>> Although there is still the race between the fork() and the
>>>> pidfd_open(), right?
>>>
>>> Actually no and my code is even too complex.
>>> If you are the parent, and this is really a sequence that obeys the
>>> ordering pidfd_open() before waiting:
>>>
>>> pid = fork();
>>> if (pid == 0)
>>>       exit(EXIT_SUCCESS);
>>> pidfd = pidfd_open(pid, 0);
>>> waitid(pid, ...);
>>>
>>> Then you are guaranteed that pidfd will refer to pid. No recycling can
>>> happen since the process has not been waited upon yet (That is,
>>
>> D'oh! Yes, of course.
> 
> You still have a race if you're the parent and you have SIGCHLD set to
> SIG_IGN though.

Yes, thanks for reminding me of that (as did Christian also).

>>> excluding special cases such as where you have a mainloop where a
>>> callback reacts to a SIGCHLD event and waits on the child behind your
>>> back and your next callback in the mainloop calls pidfd_open() while the
>>> pid has been recycled etc.).
> 
> That's a pretty common case though, especially if you're a library.

I presume that conventionally the only real resolution of this kind of
problem is that the mainloop SIGCHLD call back has a waitpid() loop
that (in a nonblocking fashion) loops checking each of the PIDs created
by the mainloop, right?

>>> A race could only appear in sequences where waiting happens before
>>> pidfd_open():
>>>
>>> pid = fork();
>>> if (pid == 0)
>>>       exit(EXIT_SUCCESS);
>>> waitid(pid, ...);
>>> pidfd = pidfd_open(pid, 0);
>>>
>>> which honestly simply doesn't make any sense. So if you're the parent
>>> and you combine fork() + pidfd_open() correctly things should be fine
>>> without even having to verify via pidfd_send_signal() (I missed that in
>>> my first mail.).
>>
>> Thanks for the additional detail.
>>
>> I added the following to the pidfd_open() page, to
>> prevent people making the same thinko as me:
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
>>        Even  if  the  child process has already terminated by the time of
>>        the pidfd_open() call, the returned file descriptor is  guaranteed
>>        to refer to the child because the parent has not yet waited on the
>>        child (and therefore, the child's ID has not been recycled).
> 
> I'd prefer that sample code be robust in all cases.

I'm not clear what you think is missing. Or do you mean that the code
can't be robust in the face of (1) waitpid(-1) in another thread or an
asynchronous SIGCHLD handler and (2) SIGCHLD disposition set to SIG_IGN?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
