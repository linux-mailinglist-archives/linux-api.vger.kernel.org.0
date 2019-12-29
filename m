Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB8C12C348
	for <lists+linux-api@lfdr.de>; Sun, 29 Dec 2019 17:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfL2QMF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Dec 2019 11:12:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35742 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfL2QMF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Dec 2019 11:12:05 -0500
Received: from [172.58.107.62] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ilbAG-00017e-6Q; Sun, 29 Dec 2019 16:11:37 +0000
Date:   Sun, 29 Dec 2019 17:11:28 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v3 1/3] samples, selftests/seccomp: Zero out seccomp_notif
Message-ID: <20191229161126.xcrnzdqu5frrov6q@wittgenstein>
References: <20191229062451.9467-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191229062451.9467-1-sargun@sargun.me>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Dec 28, 2019 at 10:24:49PM -0800, Sargun Dhillon wrote:
> The seccomp_notif structure should be zeroed out prior to calling the
> SECCOMP_IOCTL_NOTIF_RECV ioctl. Previously, the kernel did not check
> whether these structures were zeroed out or not, so these worked.
> 
> This patch zeroes out the seccomp_notif data structure prior to calling
> the ioctl.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Reviewed-by: Tycho Andersen <tycho@tycho.ws>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>

Thanks!
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
