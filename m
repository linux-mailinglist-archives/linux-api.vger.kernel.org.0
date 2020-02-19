Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740E2164443
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 13:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgBSMaD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Feb 2020 07:30:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58347 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgBSMaD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Feb 2020 07:30:03 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j4OU0-0003po-Qk; Wed, 19 Feb 2020 12:29:40 +0000
Date:   Wed, 19 Feb 2020 13:29:39 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 11/25] inode: inode_owner_or_capable(): handle fsid
 mappings
Message-ID: <20200219122939.x6o4fytdcunkvg6i@wittgenstein>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <20200218143411.2389182-12-christian.brauner@ubuntu.com>
 <20200218222523.GA9535@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200218222523.GA9535@infradead.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 18, 2020 at 02:25:23PM -0800, Christoph Hellwig wrote:
> On Tue, Feb 18, 2020 at 03:33:57PM +0100, Christian Brauner wrote:
> > +	if (is_userns_visible(inode->i_sb->s_iflags)) {
> > +		if (kuid_has_mapping(ns, inode->i_uid) && ns_capable(ns, CAP_FOWNER))
> > +			return true;
> > +	} else if (kfsuid_has_mapping(ns, inode->i_uid) && ns_capable(ns, CAP_FOWNER)) {
> 
> This adds some crazy long unreadable lines..

I'll ad a helper in the next version or wrap those lines depending on
what makes more sense.
