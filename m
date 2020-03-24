Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B4190E5D
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2020 14:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgCXNIW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Mar 2020 09:08:22 -0400
Received: from mail.efficios.com ([167.114.26.124]:40698 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgCXNIV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Mar 2020 09:08:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CB557269265;
        Tue, 24 Mar 2020 09:08:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eYeRHn1BTYTZ; Tue, 24 Mar 2020 09:08:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2282B269263;
        Tue, 24 Mar 2020 09:08:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2282B269263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1585055300;
        bh=vscCV2I2QJ7zn4zjqEONQUHahXaHD27qodsz+qj+N5c=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=n9FS7HIrUzB4LosjtAlGhk6MuBSh6RhKTudRkKI5onkBs/OtpKFmvhLcWLJFYrfRv
         YO37i8rWKRzBiHU4D3y8/+ijmZnCJSOwkO50ld0XXOg0A5zqsQ3F1O4ezquG6NpVIj
         KGwjGSgk2oD7UzA5rmWyCQ+XWrKnofg6Xpbi63TmOEyffjB+1dQ+tNMIPlsiFWMmLm
         9AOyiYrbuG1rPc5qiUfWonjImOy9u7kGAjy6f9A3Y0WimclMvDTEjzr1efkYpJY23A
         S9UTSjz9OkBibxrqCnpistHY26OP/tLuly8ap+JRVTOWvdtTkGYY5DTWOr/kwqNv8+
         xXLMnu8Z3dqDw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yQg008lDyvJ8; Tue, 24 Mar 2020 09:08:20 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 11A15269262;
        Tue, 24 Mar 2020 09:08:20 -0400 (EDT)
Date:   Tue, 24 Mar 2020 09:08:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     carlos <carlos@redhat.com>, Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>
Message-ID: <1873939476.8349.1585055299958.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.2003232159310.13609@digraph.polyomino.org.uk>
References: <20200323131607.15185-1-mathieu.desnoyers@efficios.com> <20200323131607.15185-5-mathieu.desnoyers@efficios.com> <alpine.DEB.2.21.2003232159310.13609@digraph.polyomino.org.uk>
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C
 startup and thread creation (v16)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF74 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v16)
Thread-Index: futQMa06N9Z0mgyJtVY1HcOJz1ndIA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Mar 23, 2020, at 6:01 PM, Joseph Myers joseph@codesourcery.com wrote:

> Note that we no longer use manually-written ChangeLog-format logs.

Do you mean the part at the end of the commit message ?

"   ---
    Changes since v1:" [...]

> The NEWS entry needs to move under the 2.32 header.

Done

> The new symbol needs to move to GLIBC_2.32 symbol version.

Done

Thanks for the review !

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
