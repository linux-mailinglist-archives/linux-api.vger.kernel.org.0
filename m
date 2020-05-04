Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013701C3FC6
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2020 18:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgEDQZV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 4 May 2020 12:25:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43968 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgEDQZV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 4 May 2020 12:25:21 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jVduA-0001n8-Pr; Mon, 04 May 2020 16:25:18 +0000
Date:   Mon, 4 May 2020 18:25:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/3] nsproxy: add struct nsset
Message-ID: <20200504162517.vjcbwj5ynaqdn2k4@wittgenstein>
References: <20200504144141.3605533-1-christian.brauner@ubuntu.com>
 <20200504144141.3605533-2-christian.brauner@ubuntu.com>
 <87wo5roev9.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wo5roev9.fsf@x220.int.ebiederm.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 04, 2020 at 11:15:54AM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > Add a simple struct nsset. It holds all necessary pieces to switch to a new
> > set of namespaces without leaving a task in a half-switched state which we
> > will make use of in the next patch. This patch simply switches the existing
> > setns logic over without causing a change in setns() behavior. This brings
> > setns() closer to how unshare() works(). The prepare_ns() function is
> > responsible to prepare all necessary information. This has two reasons.
> > First it minimizes dependencies between individual namespaces, i.e. all
> > install handler can expect that all fields are properly initialized
> > independent in what order they are called in. Second, this makes the code
> > easier to maintain and easier to follow if it needs to be changed.
> 
> This is buggy.
> 
> Your code assume that nstype == 0 is invalid.

Yep, good catch! That's a bug from rearranging the patches.

> 
> Passing nstype == 0 means don't verify the kind of file descriptor
> passed.
> 
> Quite frankly doing nstype & CLONE_XYZ is wrong.  It always
> needs to be nstype == CLONE_XYZ.

I mean, I can do the nstype == CLONE_NEW* in the preparatory patch and
then switch to flags & CLONE_NEW* later.

Let me fix this right now.

Christian
