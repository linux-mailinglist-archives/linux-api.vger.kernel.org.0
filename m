Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A72B6E7D
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 20:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgKQTV2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 14:21:28 -0500
Received: from mail.efficios.com ([167.114.26.124]:55746 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgKQTV2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 14:21:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1DEF02E322D;
        Tue, 17 Nov 2020 14:21:27 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id X0nhKObKDKxs; Tue, 17 Nov 2020 14:21:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BE7D72E31EC;
        Tue, 17 Nov 2020 14:21:26 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BE7D72E31EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1605640886;
        bh=ftWslqjQ2187ouDwlWAYbJygX2MLsdBiVPpx3wqODs0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gzeCy3LVkgjPVXqva8lhuGfbmjS+COnOHJinE15hvUZwW7tsKbfiJC8+ef7QSIMMb
         5cpFhrUPt/HihxbW/2Je3le9cxZFfayY/XoKNGj8tyHoDUdyK6InfZZSwCCVho4BrC
         UpPhBKxYG83Mrqx2pN+8WpF/8lTzMr7fYqomhXINWe7VHmq1cZYJAggwR6oFxXvggW
         9PZWca3019am3B6G8pM2lFgYONmolbhwwAViTA9uC95BN7vIgXLP52Uh9iHlopaG7s
         KTE9sJqvrbmmMeIKGPHl6uZErBk/BCuwmm4r1XmAztHoCkx4UY45IpM76ZjVZUqMXx
         6g7ODY8kPM7Ag==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ygUtUxCEPak5; Tue, 17 Nov 2020 14:21:26 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B0ADD2E30E6;
        Tue, 17 Nov 2020 14:21:26 -0500 (EST)
Date:   Tue, 17 Nov 2020 14:21:26 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-toolchains@vger.kernel.org
Message-ID: <1828724974.48168.1605640886598.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAPNVh5d2u84t9RV7kg6PYJc5eGFrEQV__aDX6AC2V4-s+msFvA@mail.gmail.com>
References: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com> <87k0uj6h03.fsf@mid.deneb.enyo.de> <20201117183652.GD2672@gate.crashing.org> <87r1or4yct.fsf@mid.deneb.enyo.de> <CAPNVh5d2u84t9RV7kg6PYJc5eGFrEQV__aDX6AC2V4-s+msFvA@mail.gmail.com>
Subject: Re: Is adding an argument to an existing syscall okay?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3975)
Thread-Topic: Is adding an argument to an existing syscall okay?
Thread-Index: P99UgU2Dz55k0hSegZ1WIczHxn1xoQ==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Nov 17, 2020, at 1:58 PM, Peter Oskolkov posk@google.com wrote:

> My assumption here was that applications that are aware of the new API
> will always provide three parameters, while older applications will
> continue calling the syscall with two.
> 
> I can't think of a situation/architecture where this will break anything.

I think what Florian refers to here is if there would be a glibc library
wrapper exposing the system call to applications. There, the number of
arguments would matter. But it does not exist today.

In some sense, it's a good thing that there isn't such wrapper exposed
yet. It also makes me wonder whether exposing system calls directly as a
library ABI is a good thing. It appears that library ABIs have stronger
restrictions with respect to number and types of parameters than system
calls.

Thanks,

Mathieu

> 
> Thanks,
> Peter
> 
> 
> On Tue, Nov 17, 2020 at 10:44 AM Florian Weimer <fw@deneb.enyo.de> wrote:
>>
>> * Segher Boessenkool:
>>
>> > But this isn't variadic in the sense of "..." -- on Power that always
>> > passes the unspecified arguments in memory, while in this case it just
>> > passes in either two or three registers.  I don't know any arg where
>> > that would not work, given the Linux system call restrictions.
>> >
>> > This is similar to the "open" system call.
>>
>> Exactly.  You cannot call the open function through a non-variadic
>> function pointer.  I've seen it cause stack corruption in practice:
>>
>> commit c7774174beffe9a8d29dd4fb38bbed43ece1cecd
>> Author: Andreas Schneider <asn@samba.org>
>> Date:   Wed Aug 2 13:21:59 2017 +0200
>>
>>     swrap: Fix prototype of open[64] to prevent segfault on ppc64le
>>
>>     The calling conventions for vaarg are different on ppc64le. The patch
>>     fixes segfaults on that platform.
>>
>>     Thanks to Florian Weimer who helped debugging it!
>>
>>     Signed-off-by: Andreas Schneider <asn@samba.org>
>>     Reviewed-by: Stefan Metzmacher <metze@samba.org>
>>
>> <https://git.samba.org/?p=socket_wrapper.git;a=commitdiff;h=c7774174beffe>
>>
>> It is possible to implement the open function in such a way that it
>> does not have this problem (simply do not use the parameter save area,
>> using assembler if necessary), but it's another obscure step that libc
> > implementers would have to take.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
