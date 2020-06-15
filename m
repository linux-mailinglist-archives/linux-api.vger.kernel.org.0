Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993CB1F9F5A
	for <lists+linux-api@lfdr.de>; Mon, 15 Jun 2020 20:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgFOS0r (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jun 2020 14:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOS0r (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jun 2020 14:26:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15352C061A0E
        for <linux-api@vger.kernel.org>; Mon, 15 Jun 2020 11:26:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so7930888pgo.9
        for <linux-api@vger.kernel.org>; Mon, 15 Jun 2020 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P1CWugv8At4hoVY78lLsRp7X7dhFYtlRoortuxpcFCw=;
        b=d4tyeDMohBRQ95CjvrZa6a3+G5shGbMCWFcuSB+duOdfRy9Pt43tofQfuONPluWDzq
         Y52t3/oDUaKP4VApXovO52uKEQn8ft7lABCeu60XYLM/dmrKckMGbgAwvuCza81Q5AuW
         amgFl5xx7Xe+oWtAuFd128UTX9Wpe+rpowOi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P1CWugv8At4hoVY78lLsRp7X7dhFYtlRoortuxpcFCw=;
        b=CeuXq/Umtx84QrCeYE7xy25dEJqb7BDcmx4vQ9da4nIv+nv3jOvwzQWfvjP8O74ao/
         y1jjxfx0VlV0Jn8PP1o2kqPNs758DBRH63pc9obLIdX3YMuAs/UJLWbmifCayIItzmIN
         GqFlqiD1xYzI+gNL+hEkeR0rFZbnrpjwrhXL9yNVNSzy6tIkfBwajfbSwV7vWGGm6Zjx
         IXiOgpHT9QfFkQqoFlrJjmxShzKuewFpKgOTlYqQuy278RlJRuA2LtfQWRY2B9YiKtje
         KJ41F6VPc40Fc/+3kFJPUGgHEYkQbuuVKZRU/ns0A25ew6HM3o5DvyVjiHuAqvm/rXi2
         HzJA==
X-Gm-Message-State: AOAM533Ygy2Yh3Z/O+jgA8MuIESt9b/otKKBmXIb/2QBAo+cdIDAhYOU
        /PgEq7GxPqprWJYQFpKbbjQzZw==
X-Google-Smtp-Source: ABdhPJymNtZha2b6DlF+o2cuid6oldIXzcsTAHGSwyobWdMly7LM/sU6qxJmnQfd1hAfaOhf4OjK4Q==
X-Received: by 2002:a62:3806:: with SMTP id f6mr24228613pfa.102.1592245606547;
        Mon, 15 Jun 2020 11:26:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm15158205pfk.8.2020.06.15.11.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:26:45 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:26:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] seccomp: Add extensibility mechanism to read
 notifications
Message-ID: <202006151125.5FAE400D0@keescook>
References: <20200613072609.5919-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613072609.5919-1-sargun@sargun.me>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Jun 13, 2020 at 12:26:09AM -0700, Sargun Dhillon wrote:
> This introduces an extensibility mechanism to receive seccomp
> notifications. It uses read(2), as opposed to using an ioctl. The listener
> must be first configured to write the notification via the
> SECCOMP_IOCTL_NOTIF_CONFIG ioctl with the fields that the user is
> interested in.

FYI: I'm not ignoring this, but I'm trying to get the other series
nailed down first. I'll cycle back around to this soon.

-- 
Kees Cook
