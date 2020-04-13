Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23521A6F6D
	for <lists+linux-api@lfdr.de>; Tue, 14 Apr 2020 00:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389719AbgDMWte (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Apr 2020 18:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389721AbgDMWqm (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 13 Apr 2020 18:46:42 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A362072A;
        Mon, 13 Apr 2020 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586818066;
        bh=O8JIyaqeyITmglng3FI2Tz5jEQL86mOs7ypEWh4wxfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vhWBbVfQ+SH+sUP4bDHgfQh6I0aLXNdXZ7purDhfK2uPYKZxKy6kgHSAcHGwVbM5e
         xClnGmm5H8+GJYIi1VMe7zFmSqsUEOw4joMzr84EhSvBS2D79sjAa27TzvWQD9b6WF
         SprL8snh1ZlBzTokaGn+XToesSaM53ZPB97x9qdA=
Date:   Mon, 13 Apr 2020 15:47:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     mtk.manpages@gmail.com
Cc:     Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH v2] timens: show clock symbolic names in
 /proc/pid/timens_offsets
Message-Id: <20200413154746.39275d0981f69e57a7ecab3e@linux-foundation.org>
In-Reply-To: <CAKgNAki6uBHVTBdJvj7hzbho9Z94MWRV7ab8npduogQohRndBQ@mail.gmail.com>
References: <96bedbaf-49ea-f24b-b7b1-fb9a57fb6c7d@gmail.com>
        <20200411154031.642557-1-avagin@gmail.com>
        <CAKgNAki6uBHVTBdJvj7hzbho9Z94MWRV7ab8npduogQohRndBQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, 12 Apr 2020 07:51:47 +0200 "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> wrote:

> Hi Andrei,
> 
> On Sat, 11 Apr 2020 at 17:40, Andrei Vagin <avagin@gmail.com> wrote:
> >
> > Michael Kerrisk suggested to replace numeric clock IDs on symbolic
> > names.
> >
> > Now the content of these files looks like this:
> > $ cat /proc/774/timens_offsets
> > monotonic      864000         0
> > boottime      1728000         0
> 
> Thanks.
> 
> Assuming no-one has objections to the patch, please do mark for stable@.
> 

`grep -r timens_offsets Documentation' comes up blank.  Is
/proc/pid/timens_offsets documented anywhere?  If not, it should be! 
And this patch should update that documentation.

I assume the time namespace feature itself is documented under clone(2)?
