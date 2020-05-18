Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405871D89CF
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2020 23:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgERVKj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 17:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVKj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 17:10:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D2C061A0C
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 14:10:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so3156440pgm.0
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=02zTdmWvuhMAmu2ssQyvw6TTLQFpo9NVSwY+R1u73VY=;
        b=gAXE4XpV+CS3MUzPaSu04TFze1uh9z13q7TUdzdjq1D07GUaXHKHaUQzff7/WhoD6l
         WxQ0PBeQoQd7DpwoLKG/0/No4/eSeR/EDgWDAJfgU9GbwOZRQRI+DM/veXDczDNtmx5a
         roH9kSmO5mV1oQYZqA7gfZXVpkGae1YKks7Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=02zTdmWvuhMAmu2ssQyvw6TTLQFpo9NVSwY+R1u73VY=;
        b=CmAo4wukzeIuBjqDlEb1tKJsUiS9gq5UGxeRCLd1mYNb/31uxp3kxB+K97/oSspufl
         pm2euXhFiZHNG/p4c6p0WSNEMGnPU6gLgM991YalzbzQ27kddveGq26F6ljNVx3CKMJD
         ICVupaEUVYulAZsawLA+CsVQpwAhuDJAHUBPqNVC9ZNecxRFN8DlmxWI2baUs5QC1xdv
         aeGI7Fjh6NdBSm2E4CskfqLK+5mY6Sb0ngn2ll4NjSIys/VkgawHOKX/8eEJ8TrnusYh
         FcEXG5cziqsGlzrxfjPnkBaqrTPG+hc1Du8fSZeFGC28L/AoghvJfmjI7I7f+JGnZK+E
         L/SA==
X-Gm-Message-State: AOAM532rhYlv/JRffToxOBZYFPM30O3mA90nevZ4Bv73fSzSBKPUVC2d
        CO6otJiVrAzcXpMex0bH1OsPQ/f4/xw=
X-Google-Smtp-Source: ABdhPJwgyL7qadxNPz/Mn0mpWZEUmq5QEMkziZLtBB2Ei8yrQXRte4glp9kkv3QgQOWsAPUrHLt90A==
X-Received: by 2002:a63:6f4c:: with SMTP id k73mr16449725pgc.241.1589836238493;
        Mon, 18 May 2020 14:10:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o190sm9514518pfb.178.2020.05.18.14.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 14:10:37 -0700 (PDT)
Date:   Mon, 18 May 2020 14:10:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <asarai@suse.de>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <202005181405.AF40001D@keescook>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
 <20200517142316.GA1996744@cisco>
 <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
 <20200517144603.GD1996744@cisco>
 <20200517150215.GE1996744@cisco>
 <202005171428.68F30AA0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202005171428.68F30AA0@keescook>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 17, 2020 at 02:30:57PM -0700, Kees Cook wrote:
> Anyway, it's very related to this, so, yeah, probably we need a v2 of the
> notif API, but I'll try to get all the ideas here collected in one place.

For future thread archæologists, I put my thoughts here:
https://lore.kernel.org/lkml/202005181120.971232B7B@keescook/

-- 
Kees Cook
