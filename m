Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4177D1C4017
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2020 18:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgEDQjL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 4 May 2020 12:39:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44285 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbgEDQjK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 4 May 2020 12:39:10 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jVe7Y-00037e-KN; Mon, 04 May 2020 16:39:08 +0000
Date:   Mon, 4 May 2020 18:39:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 2/3] nsproxy: attach to namespaces via pidfds
Message-ID: <20200504163907.jjgqe7qnnjpw4uwo@wittgenstein>
References: <20200504144141.3605533-1-christian.brauner@ubuntu.com>
 <20200504144141.3605533-3-christian.brauner@ubuntu.com>
 <87h7wvoefw.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h7wvoefw.fsf@x220.int.ebiederm.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 04, 2020 at 11:25:07AM -0500, Eric W. Biederman wrote:
> 
> I am not thrilled about treating nstype as a flags fields when it is not
> currently.  It was my hope when I designed the interface that not
> treating nstype as a flags field would save us from the problem of bits
> running out.

Hm, I researched the setns() syscall history before that and I didn't
see that reasoning anywhere. The "nstype" arg was originally advertised
on the list as "having a flags field is useful in general".

> 
> That aside.  It would be very good if the default version of setting
> everything from a pidfd would set the root directory from the process it
> is copying everything else from.

I'm not sure I follow completely. If you specify CLONE_NEWNS then we do
set the root directory with set_fs_root() in commit_nsset(). Or are you
saying we should always do that independent of whether or not
CLONE_NEWNS is specified? And if so could you explain why we'd want
that? I'm sure I'm missing something!

Christian
