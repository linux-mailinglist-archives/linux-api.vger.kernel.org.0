Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D14A1FD4B2
	for <lists+linux-api@lfdr.de>; Wed, 17 Jun 2020 20:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgFQSk3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Jun 2020 14:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgFQSkZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Jun 2020 14:40:25 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DBBC06174E
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2020 11:40:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y18so1345206plr.4
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2020 11:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KcSum0XnLgDWG/9J1zd7huPRZUcbTdd3T0stJfNhXtU=;
        b=hHeKJA5bpWojfm1pX2unVw+EfqUuRl8oPBdUNPLoCxjZ64sU0oStIKYfknHILmDFaZ
         H9ZHJAe3xkt0qMgGgjNa6EjvRt/0qyjX/4NrDrZCZMQNniC1zsg9rGq+JkViIVv/0vWR
         +7lVX4VJq+6OYKuN/6lWKksWFEEFKKkIWjELs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KcSum0XnLgDWG/9J1zd7huPRZUcbTdd3T0stJfNhXtU=;
        b=Di4/DIE9DSS1/Jkr6/THajpESu3bVWIEAJkf36x7VA9cR3j3bfok/YMfHbOEDrGXiG
         GGCy2k9Cv5bQIx5i99/N1zL/Z8i8i9HHGO4CNabCPYkCtueiTLDPUhel+gIeEfo4vDZL
         gwW83a8Utu5hzNAV2GwXKTdoH+pUpdCrwncLH/TluTycqM97vUkei+H8AmIRlGMnszoW
         Y+VQLWyyRqLZbBcyhq7tdnzyd8CPFnfTdtXeEP/MW5gPUM70kcNzAHGljOEEzdmHZvTb
         Ez0sXxLpBKHC2JEvd6bskOkFXm/iinJRY6xcknGtq74vBNEReT0T/evI6CsNYQR1UL25
         FmLg==
X-Gm-Message-State: AOAM532NefLycWtYW48XRttN6jjwVkqP+R1p8/K1htDFTwLJFrvVppSy
        rJM4x5WbzPAUoNmnKMBhD3fFlQ==
X-Google-Smtp-Source: ABdhPJzMCEeKbMD2vkbh+chVGcN7dvBNIk/GO49GvRnea+7Iwh7JIl8l4xjbafw6OC9ChWgKjmpkjA==
X-Received: by 2002:a17:90a:218c:: with SMTP id q12mr383955pjc.116.1592419223126;
        Wed, 17 Jun 2020 11:40:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u128sm506788pfu.148.2020.06.17.11.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 11:40:21 -0700 (PDT)
Date:   Wed, 17 Jun 2020 11:40:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 02/11] fs: Move __scm_install_fd() to
 __fd_install_received()
Message-ID: <202006171139.98B1735@keescook>
References: <20200616032524.460144-1-keescook@chromium.org>
 <20200616032524.460144-3-keescook@chromium.org>
 <b58ef9a368214b69a86c7a78b67f84d5@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b58ef9a368214b69a86c7a78b67f84d5@AcuMS.aculab.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 17, 2020 at 03:25:41PM +0000, David Laight wrote:
> From: Kees Cook
> > Sent: 16 June 2020 04:25
>  
> > In preparation for users of the "install a received file" logic outside
> > of net/ (pidfd and seccomp), relocate and rename __scm_install_fd() from
> > net/core/scm.c to __fd_install_received() in fs/file.c, and provide a
> > wrapper named fd_install_received_user(), as future patches will change
> > the interface to __fd_install_received().
> 
> Any reason for the leading __ ??

Mainly because of the code pattern of only using the inline helpers to
call it.

-- 
Kees Cook
