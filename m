Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C85191A3F
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2020 20:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgCXTo7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Mar 2020 15:44:59 -0400
Received: from mail.efficios.com ([167.114.26.124]:35206 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCXTo7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Mar 2020 15:44:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A178426CC74;
        Tue, 24 Mar 2020 15:44:58 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KlUo0PFuqzlt; Tue, 24 Mar 2020 15:44:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3AB3D26CF80;
        Tue, 24 Mar 2020 15:44:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3AB3D26CF80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1585079098;
        bh=EOvwRt//tfRS27woHCwYV1oIOJw5868xS1N0BbJF0Ps=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QsZKNsAIov7+AFWzhh+erOXHeondRgv6BlcGVXFsb/ihUEf5Ao7z5VFLLKMOfpVCu
         VSmNCBYuzCk+v7bPx8we/D2baRC401klafVcIRgj0M+275YKB0niqWVsTR0+iP3fgD
         Q4tAM8rg9G8k9qab5jvICjxzydJFaJCojV6oMb+/QjdvwuCutbwu1C1Sd3/bJSKM7Q
         S5UUQ2b38w5l3F8EtM9CPSFZORRKDZ5fkkU1ww1e5vpPIEMTw1RhMaNrajZUj7+iOo
         /lIL19Vi2+sgIQZqtdZ/WV9yxE8olNwdMSPjw9/jDCO1ZAxAkaM8LCnZTuzdY8PdTD
         wTvymo56FB9Qg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nMPC8AM_o8PR; Tue, 24 Mar 2020 15:44:58 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 27BBA26CE27;
        Tue, 24 Mar 2020 15:44:58 -0400 (EDT)
Date:   Tue, 24 Mar 2020 15:44:58 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>
Message-ID: <1094187167.10225.1585079098074.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.2003241857350.8310@digraph.polyomino.org.uk>
References: <20200323131607.15185-1-mathieu.desnoyers@efficios.com> <20200323131607.15185-5-mathieu.desnoyers@efficios.com> <alpine.DEB.2.21.2003232159310.13609@digraph.polyomino.org.uk> <1873939476.8349.1585055299958.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.2003241857350.8310@digraph.polyomino.org.uk>
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C
 startup and thread creation (v16)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF74 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v16)
Thread-Index: JDnp6/Oado3vQ4/sidiioZ9DbRGBfQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Mar 24, 2020, at 2:58 PM, Joseph Myers joseph@codesourcery.com wrote:

> On Tue, 24 Mar 2020, Mathieu Desnoyers via Libc-alpha wrote:
> 
>> ----- On Mar 23, 2020, at 6:01 PM, Joseph Myers joseph@codesourcery.com wrote:
>> 
>> > Note that we no longer use manually-written ChangeLog-format logs.
>> 
>> Do you mean the part at the end of the commit message ?
> 
> I mean the
> 
>	* filename: Changes to this file.
>	* other/file: Likewise.
> 
> part.

Thanks for the clarification! Now done in preparation for next round.

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
