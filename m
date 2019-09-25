Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 285F2BDF5C
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 15:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfIYNqa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 09:46:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36627 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406885AbfIYNqa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 09:46:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id m18so5065065wmc.1;
        Wed, 25 Sep 2019 06:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iKsFIEd0uBwIY3tTGRR20DzAbYFoSzNfDXIkMLH2wxk=;
        b=kDXwrpxdArXQ/wTsRLc8YoiVy09xzYoOAaJ1TFvb2v1kZUm3nFs0PETlL86zdjfVNe
         a1ttJj7pylGtvnKDmCUKCa6d4iTCofvaMoGPlLRjNvie1JAOMKXMaUxneujm7M/DhvDH
         OGGeGilv41bbwa8kSfwTUliat+yBMXcbGZs69qru90DsRR1KfSq7w0KnCb9oitFHexfT
         8i5aAE9iGY8otO1UR0bzU7oOhwiaDz53FMTb6L8t5+Two7AEe+d3HiV2P3AgBXbWh5Ys
         cXJWh/peIEwT7XQ5+afcOhbYKbWOp61OYSbsK4yu2AIr38y3Z1GVt2tWV4njY7xg9hTM
         gApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iKsFIEd0uBwIY3tTGRR20DzAbYFoSzNfDXIkMLH2wxk=;
        b=lK8+ttXmX6qrVO2oNKi39HQNWGVwxEOAqxxh77k6YOuMB1Xr7tBKpgewqpZGozYdln
         /5efB0pdt4prvYs12p/5udFqsKeTXZd3lw/B7Dld50Nan54Lnncx/aDIBeD7SKBp9gvP
         njrTlISqHA/9mFLEU8jQ54c+Ydd1GKXrOH5r5Gy42A6hSzW4Y90p/iQRf9J8+zuWb+R0
         ZUqxpvOVpBBf2SR4Kkq7XBa4Sdyl+CAHTxw6lnsflP+Z9NxJnSvvrvJbho4XGgxBhPS4
         tBg4u4HLWU5JIg93VJWf/xNcwEuTyD03fTt2VghsVYvSAomaMY2XoiBySJQawMQ52GiR
         vmoQ==
X-Gm-Message-State: APjAAAV00LJ1Og0f3ND2H1457MX5s/jQUz19FFxdwXDm9xNdg9l0sMAJ
        Sp38RwiilSArwDHFiePZ0aU7hBtU
X-Google-Smtp-Source: APXvYqx/j2yoYColnVe5aftjqddbf0WOAh6RpZUyg1lE00aP82au8iJHUB51+MxjRvHlnjzbVJBrGw==
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr8281324wmm.98.1569419187294;
        Wed, 25 Sep 2019 06:46:27 -0700 (PDT)
Received: from [10.0.20.253] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id x5sm5953548wrt.75.2019.09.25.06.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 06:46:26 -0700 (PDT)
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
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <331cc245-3f70-dd43-31f9-8c1680ca6b20@gmail.com>
Date:   Wed, 25 Sep 2019 15:46:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190924215316.gxev2anuqffegocw@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/24/19 11:53 PM, Christian Brauner wrote:
> On Tue, Sep 24, 2019 at 11:00:03PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hello Christian,
>>
>>>>> If you're the parent of the process you can do this without CLONE_PIDFD:
>>>>> pid = fork();
>>>>> pidfd = pidfd_open();
>>>>> ret = pidfd_send_signal(pidfd, 0, NULL, 0);
>>>>> if (ret < 0 && errno == ESRCH)
>>>>> 	/* pidfd refers to another, recycled process */
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
>>> 	exit(EXIT_SUCCESS);
>>> pidfd = pidfd_open(pid, 0);
>>> waitid(pid, ...);
>>>
>>> Then you are guaranteed that pidfd will refer to pid. No recycling can
>>> happen since the process has not been waited upon yet (That is,
>>
>> D'oh! Yes, of course. 
>>
>>> excluding special cases such as where you have a mainloop where a
>>> callback reacts to a SIGCHLD event and waits on the child behind your
>>> back and your next callback in the mainloop calls pidfd_open() while the
>>> pid has been recycled etc.).
>>> A race could only appear in sequences where waiting happens before
>>> pidfd_open():
>>>
>>> pid = fork();
>>> if (pid == 0)
>>> 	exit(EXIT_SUCCESS);
>>> waitid(pid, ...);
>>> pidfd = pidfd_open(pid, 0);
>>>
>>> which honestly simply doesn't make any sense. So if you're the parent
>>> and you combine fork() + pidfd_open() correctly things should be fine
>>> without even having to verify via pidfd_send_signal() (I missed that in
>>> my first mail.).
>>
>> Thanks for the additional detail.
> 
> You're very welcome.
> 
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
> Thanks! I'm fine with the example. The code illustrates the basics. If
> you want to go overboard, you can mention my callback example and put my
> SIG_IGN code snippet from my earlier mails (cf. [1] and [2]) in there.
> But imho, that'll complicate the manpage and I'm not sure it's worth it.

I agree that we should not complicate this discussion with more code,
but how about we refine the text as follows:

       The following code sequence can be used to obtain a file  descrip‐
       tor for the child of fork(2):

           pid = fork();
           if (pid > 0) {     /* If parent */
               pidfd = pidfd_open(pid, 0);
               ...
           }

       Even  if  the  child  has  already  terminated  by the time of the
       pidfd_open() call, its PID will not have  been  recycled  and  the
       returned  file  descriptor  will  refer  to  the  resulting zombie
       process.  Note, however, that this is guaranteed only if the  fol‐
       lowing conditions hold true:

       *  the  disposition  of  SIGCHLD  has  not  been explicitly set to
          SIG_IGN (see sigaction(2)); and

       *  the zombie process was not  reaped  elsewhere  in  the  program
          (e.g.,  either  by an asynchronously executed signal handler or
          by wait(2) or similar in another thread).

       If these conditions don't hold true, then the child process should
       instead be created using clone(2) with the CLONE_PID flag.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
