Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11EE2B675B
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 15:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgKQO2n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 09:28:43 -0500
Received: from mail.efficios.com ([167.114.26.124]:57560 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgKQO2n (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 09:28:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CF3F72E06C7;
        Tue, 17 Nov 2020 09:28:41 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id O_VS5QOc43TJ; Tue, 17 Nov 2020 09:28:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 952402E06C6;
        Tue, 17 Nov 2020 09:28:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 952402E06C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1605623321;
        bh=0FQwR6rczTZMYoYMOVLsPCxXwfIFesuddkR+IgOj37Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WB/3nIfkR50y6k3W9pkDUx6XbqK7IeHE2tuxlDNq1m8dhUXZUMR1+dMZgsAeiKkjv
         nKcJXEgtWKlubfAW7mvRs2hUWBBLytsmgP0YkN6g8r7SP6muLcfhJoSBSqpVP/k0aU
         eSKaTa9dkGlnm78BJAUBKylQAWyEkDQzblN2kvUGtwqKaPSBcYVjawRUbR4bd1QBwM
         fhk9R3jfx3r0sRBwmRtGVuBaNR4IL8l2WUxbDRY89SBBg6PoqZZtDCg8TDZceYeZP7
         RZn8bmMXNnc6T5f/hLzLEzYI3THJbraUYI1ezv89CU0hLaBtFtn3MRQgM/CIEA/Iei
         HN53YM4urphUg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0RT43ZNkUwWJ; Tue, 17 Nov 2020 09:28:41 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 86C102E06C5;
        Tue, 17 Nov 2020 09:28:41 -0500 (EST)
Date:   Tue, 17 Nov 2020 09:28:41 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-api <linux-api@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <621527792.47384.1605623321460.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
References: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
Subject: Re: Is adding an argument to an existing syscall okay?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3975)
Thread-Topic: Is adding an argument to an existing syscall okay?
Thread-Index: rSZkK7YOdWhdpW695WZvp+si/GxLxQ==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Nov 16, 2020, at 6:57 PM, Andy Lutomirski luto@kernel.org wrote:

> Linux 5.10 contains this patch:
> 
> commit 2a36ab717e8fe678d98f81c14a0b124712719840
> Author: Peter Oskolkov <posk@google.com>
> Date:   Wed Sep 23 16:36:16 2020 -0700
> 
>    rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
> 
> This adds an argument to an existing syscall.  Before the patch,
> membarrier had 2 parameters; now it has 3.  Is this really okay?  At
> least the patch is careful and ignores the third parameter unless a
> previously unused flag bit is set.

Hi Andy,

I wondered about exactly this on August 12 2020:

https://lore.kernel.org/r/1477195446.6156.1597261492255.JavaMail.zimbra@efficios.com

And then on August 25, after receiving no feedback, I told Peter to try this approach:

https://lore.kernel.org/r/1336467655.17779.1598374701401.JavaMail.zimbra@efficios.com

and nobody complained until now. As you note, the extra argument is only used when
previously unused flag bits are set.

So your question is very relevant, and I still look forward to receiving feedback
on this matter.

Thanks,

Mathieu

> 
> --Andy

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
