Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2101315BEB4
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 13:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgBMMwe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 07:52:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43272 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgBMMwe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 07:52:34 -0500
Received: from [95.91.247.236] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2Dyq-0008Ec-H6; Thu, 13 Feb 2020 12:52:32 +0000
Date:   Thu, 13 Feb 2020 13:52:31 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 0/6] clone3 & cgroups: allow spawning processes into
 cgroups
Message-ID: <20200213125231.3vod5lckaej6na7w@wittgenstein>
References: <20200205132623.670015-1-christian.brauner@ubuntu.com>
 <20200212230127.GA88887@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212230127.GA88887@mtj.thefacebook.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 12, 2020 at 06:01:27PM -0500, Tejun Heo wrote:
> On Wed, Feb 05, 2020 at 02:26:17PM +0100, Christian Brauner wrote:
> > Hey Tejun,
> > 
> > This is v6 of the promised series to enable spawning processes into a
> > target cgroup different from the parent's cgroup.
> 
> Applied 1-6 to cgroup/for-5.7. There was a conflict with 0cd9d33ace33
> ("cgroup: init_tasks shouldn't be linked to the root cgroup") which
> got fixed up while applying. I'd really appreciate if you can take a
> look to see everything is ok.

Looked at it just now and all seems sane.
The reference to init_tasks threw me off at first. I initially thought
you're talking about pid namespace inits but you mean tasks created via
fork_idle() here. Since those tasks can't be created with
CLONE_INTO_CGROUP set it's perfectly safe to set cset = NULL
unconditionally.
Thanks for fixing the merge conflict!
> 
> Thanks a lot for working on this. This is really great.

Thanks, I think so too!
Christian
