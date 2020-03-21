Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E601D18E53C
	for <lists+linux-api@lfdr.de>; Sat, 21 Mar 2020 23:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgCUWaV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 21 Mar 2020 18:30:21 -0400
Received: from forward105p.mail.yandex.net ([77.88.28.108]:40704 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727700AbgCUWaV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 21 Mar 2020 18:30:21 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Mar 2020 18:30:19 EDT
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 73E9F4D40E7E;
        Sun, 22 Mar 2020 01:24:06 +0300 (MSK)
Received: from mxback4q.mail.yandex.net (mxback4q.mail.yandex.net [IPv6:2a02:6b8:c0e:6d:0:640:ed15:d2bd])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 6E823CF40002;
        Sun, 22 Mar 2020 01:24:06 +0300 (MSK)
Received: from vla1-bdd5685c3f79.qloud-c.yandex.net (vla1-bdd5685c3f79.qloud-c.yandex.net [2a02:6b8:c0d:4201:0:640:bdd5:685c])
        by mxback4q.mail.yandex.net (mxback/Yandex) with ESMTP id ZeWZYb8O5m-O6lCQIpf;
        Sun, 22 Mar 2020 01:24:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1584829446;
        bh=C2xVe2PIuH9rWg0p608J2xRKb7GLPXXF9rWS1X8kHYY=;
        h=In-Reply-To:From:To:Subject:Cc:Date:References:Message-ID;
        b=MzX9gd+YqAQxkBQWUUL9nx3q3XoD2h7840na5Re8WrlP89axDxjDOqe8CdXoPpsiH
         ZDr+VAzt3lNIE2c4U21oLmmWgxzoxkdAzPksxNwdJ9g+y1NrQAcHva0EU1CX27GnP5
         F4cz8MZzyONRSVBJFgwxYlQmNGssQPQzoUrY8xwY=
Authentication-Results: mxback4q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-bdd5685c3f79.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id DqRcswWVlk-O5ZmaB9I;
        Sun, 22 Mar 2020 01:24:05 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [RFC][possible bug] when should SS_AUTODISARM have effect?
To:     Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200319021629.GC23230@ZenIV.linux.org.uk>
 <CALCETrULZc+T6MeRwfcf=JGoh0xE0YEsTFeLiB5=zdH8AX+3bg@mail.gmail.com>
From:   stsp <stsp2@yandex.ru>
Message-ID: <4b34bac5-9c1e-c1bb-c033-cd373efc1745@yandex.ru>
Date:   Sun, 22 Mar 2020 01:24:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CALCETrULZc+T6MeRwfcf=JGoh0xE0YEsTFeLiB5=zdH8AX+3bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

21.03.2020 20:59, Andy Lutomirski пишет:
> On Wed, Mar 18, 2020 at 7:16 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>          Consider the following scenario:  SIGPIPE has SA_ONSTACK
>> handler, SIGSEGV - non-SA_ONSTACK one.  SIGPIPE is delivered
>> and we fail halfway through setting a sigframe for it.
>> OK, we get SIGSEGV forced in, which gets handled not on altstack.
>> But what should happen if we fail *after* having saved the
>> altstack settings into the sigframe that got abandoned?
>>
>>          AFAICS, we get them reset and the original setting
>> entirely lost.  Shouldn't that thing be applied only after
>> we have succeeded in building the frame?  In signal_delivered(),
>> perhaps...
>>
>>          I realize that this is out of scope for POSIX, so it's
>> not a matter of standard compliance, but it looks like a bit
>> of a QoI issue...
> I suspect that the number of real programs that usefully handle
> SIGSEGV due to signal delivery failure is extremely low.  And the
> number of real programs that use SA_ONSTACK and expect to survive when
> the alternate stack is bad may well be zero.
>
> Honestly, if we actually want to make any of this useful, I think a
> better design would be to use an entirely separate signal specifically
> for signal delivery failure.  So we'd have SIGBADSIG, and signal
> delivery failure tries to deliver SIGBADSIG.  The current design is
> like if x86 handled exception failure by sending #PF.  The results
> would be nonsensical.
>
> But adding a feature like this would be silly unless someone actually
> wanted to use it.
> .

IMHO the signal delivery failure should
either call do_exit(), or be quite close to
sigreturn() failure, which is a SIGSEGV
with special si_code IIRC. If you ask me
(as probably the only user of SS_AUTODISARM,
special si_code and all that), I'd say that
I can live well without yet another notification
method. :) And you can always invent new
si_code rather than new signum, in case
the new method is really needed.

