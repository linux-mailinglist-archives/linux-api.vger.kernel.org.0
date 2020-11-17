Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25E32B6B0A
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 18:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgKQRFk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 12:05:40 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51475 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726204AbgKQRFk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 12:05:40 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AHH5Ml6021679
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 12:05:23 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 49E12420107; Tue, 17 Nov 2020 12:05:22 -0500 (EST)
Date:   Tue, 17 Nov 2020 12:05:22 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Is adding an argument to an existing syscall okay?
Message-ID: <20201117170522.GC445084@mit.edu>
References: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 16, 2020 at 03:57:40PM -0800, Andy Lutomirski wrote:
> Linux 5.10 contains this patch:
> 
> commit 2a36ab717e8fe678d98f81c14a0b124712719840
> Author: Peter Oskolkov <posk@google.com>
> Date:   Wed Sep 23 16:36:16 2020 -0700
> 
>     rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
> 
> This adds an argument to an existing syscall.  Before the patch,
> membarrier had 2 parameters; now it has 3.  Is this really okay?  At
> least the patch is careful and ignores the third parameter unless a
> previously unused flag bit is set.

So I can't see a way in which this would be problematic.  I guess it
might mean that strace might not be able to properly display the extra
parameter if it doesn't know about the new flag, but that would also
be true if we used part of a padding field for a new structure element.

Flipping around the question, why would this *NOT* be okay?

  	      	   	     	     	   - Ted
