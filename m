Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F229E520E
	for <lists+linux-api@lfdr.de>; Fri, 25 Oct 2019 19:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505791AbfJYRJB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Oct 2019 13:09:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51551 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505797AbfJYRHa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Oct 2019 13:07:30 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iO33g-0000qH-Bv; Fri, 25 Oct 2019 17:07:28 +0000
Date:   Fri, 25 Oct 2019 19:07:27 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: For review: documentation of clone3() system call
Message-ID: <20191025170726.rqsquw4v4cuhduek@wittgenstein>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 25, 2019 at 06:59:31PM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Christian and all,
> 
> I've made a first shot at adding documentation for clone3(). You can
> see the diff here:
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=faa0e55ae9e490d71c826546bbdef954a1800969
> 
> In the end, I decided that the most straightforward approach was to
> add the documentation as part of the existing clone(2) page. This has
> the advantage of avoiding duplication of information across two pages,
> and perhaps also makes it easier to see the commonality of the two
> APIs.
> 
> Because the new text is integrated into the existing page, I think it
> makes most sense to just show that page text for review purposes. I
> welcome input on the below.
> 
> The notable changes are:
> * In the first part of the page, up to and including the paragraph
> with the subheading "The flags bit mask"
> * Minor changes in the description of CLONE_CHILD_CLEARTID,
> CLONE_CHILD_SETTID, CLONE_PARENT_SETTID, and CLONE_PIDFD, to reflect
> the argument differences between clone() and clone2()
> 
> Most of the resy of page is unchanged.
> 
> I welcome fixes, suggestions for improvements, etc.

Thank you Michael, for doing this. I will hopefully get around to
reviewing this soon but it might take a few days (latest after next week
:( because of OSS/LSS).

Christian
