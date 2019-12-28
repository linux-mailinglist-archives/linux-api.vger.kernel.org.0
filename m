Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF0712BD1E
	for <lists+linux-api@lfdr.de>; Sat, 28 Dec 2019 10:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfL1J0E (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Dec 2019 04:26:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39297 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfL1J0D (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 28 Dec 2019 04:26:03 -0500
Received: from [46.183.103.8] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1il8MB-0001LD-5A; Sat, 28 Dec 2019 09:26:01 +0000
Date:   Sat, 28 Dec 2019 10:25:34 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        tycho@tycho.ws, jannh@google.com, keescook@chromium.org,
        cyphar@cyphar.com
Subject: Re: [PATCH v2 1/2] samples, selftests/seccomp: Zero out seccomp_notif
Message-ID: <20191228092533.wm6w3r7eyhif5pfi@wittgenstein>
References: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Dec 28, 2019 at 01:48:39AM +0000, Sargun Dhillon wrote:
> The seccomp_notif structure should be zeroed out prior to calling the
> SECCOMP_IOCTL_NOTIF_RECV ioctl. Previously, the kernel did not check
> whether these structures were zeroed out or not, so these worked.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: Kees Cook <keescook@chromium.org>

Can you please also add a test, that verifies that we catch garbage
values, please?
