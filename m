Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE11381F8
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2019 01:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfFFXym (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 6 Jun 2019 19:54:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47961 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726609AbfFFXym (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 6 Jun 2019 19:54:42 -0400
Received: from callcc.thunk.org (61.0.32.70.hosted.by.gigenet.com [70.32.0.61] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x56NsaZ4016149
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jun 2019 19:54:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B5F9C420481; Thu,  6 Jun 2019 19:54:35 -0400 (EDT)
Date:   Thu, 6 Jun 2019 19:54:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC]: Convention for naming syscall revisions
Message-ID: <20190606235435.GD23169@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Christian Brauner <christian@brauner.io>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190606154224.7lln4zp6v3ey4icq@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606154224.7lln4zp6v3ey4icq@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 06, 2019 at 05:42:25PM +0200, Christian Brauner wrote:
> Hey everyone,
> 
> I hope this is not going to start a trash fire.
> 
> While working on a new clone version I tried to find out what the
> current naming conventions for syscall revisions is. I was told and
> seemed to be able to confirm through the syscall list that revisions of
> syscalls are for the most part (for examples see [1]) named after the
> number of arguments and not for the number of revisions. But some also
> seem to escape that logic (e.g. clone2).

There are also examples which show that it's a revision number:

      preadv2, pwritev2, mlock2, sync_file_range2

immediately come to mind.  It's also important to note that in some
cases, we do something very different (look aht the stat and fstat
variants), and that in some cases the number of parameters for a
system call vary between architectures (because of system call
argument passing limitations), and this gets papered over by glibc.

So we can define what the historical pattern, but there might be a big
difference between what might make sense as an internal naming
convention, and the names that we want to expose to userspace
application programmers --- especially if the number of arguments at
the syscall level might be different (on some architectures) than at
the C library level.

					- Ted
