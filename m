Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA80612BC7D
	for <lists+linux-api@lfdr.de>; Sat, 28 Dec 2019 05:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfL1Dt0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 27 Dec 2019 22:49:26 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35552 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfL1DtZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Dec 2019 22:49:25 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so23793149ild.2
        for <linux-api@vger.kernel.org>; Fri, 27 Dec 2019 19:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fW4oSj2ujLoinwXahbBj146hJbvQqiumz2p1q9AEvF8=;
        b=mVYrxfdc0XAsVAFSGNI6GvI3HPDntzPtAlQuuhh9YSh3zsttcIpdX6ooe9UlKCINN8
         AEoIFpNDQV84RWnPnUpPbSAvp8ZCumCj4pSsOkDbGMcrUCV4y2Vw/gPl5NKJw5Rqdb/b
         3oAKiXd3Fv07EbDXpZEOAqFGewQpY4YlPsV5O0fDATY9kdrTpkZGsaqFEn0+79hZlKF+
         q2+9BmF5MEqQLeaCbXIWlBTGVGixnH74iDFoBhKpQh4mA1GaocFvM+QoMzqXbmN4FnZC
         jyWA2UsSqlvFRaQ9ALjvT6R92RMl9kbIEPgPIWjjvOyGX1miDAubAyOztZsFGjfyTW+N
         84nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fW4oSj2ujLoinwXahbBj146hJbvQqiumz2p1q9AEvF8=;
        b=H6RG5dFdYAmxKRfTiiGQ+uPeJzQ571DeiR4TsFQ+ZbDqWPUoKQElSuC5wEfu5ekVRS
         r66lLcVCrXEw1dbLTilU50yRa7zUNxDO17bNQ+GvsTaF/L/bvFvr9Kz7VYq8JOf0y13U
         Q5WvUKugkTSX+f24cXVIWLJ+j7W0rClxQiJi29cTuyxwVs7yHvfeR22mFvC5qBEKl4fh
         +KardSbo4pVUtKmB35bCFP99If38BxiVjp/8kn7tnaug0GRVZO45DIQsTDzQaK5OzANS
         +HRW/BhDKg0vx2amoUlwUHNy7lB7ST1qy4frPXnfE63m/UkD05kfRQdjjoJPX0BgKVAD
         q/xw==
X-Gm-Message-State: APjAAAUNI4ohTsXZkXk9hUIxAmUrOH6d2XXpBEImm0eLq2n4V2oEp5DD
        sQePMRh/+eH+GprnbQB5EpSdRg==
X-Google-Smtp-Source: APXvYqy95YEE+vlkJ65Homi/8eJPYaJsqJMTy7PymXaZETZnjEU6uKsbnfju/5VySBEuI+U7HJ6M5g==
X-Received: by 2002:a92:88d0:: with SMTP id m77mr50028181ilh.9.1577504965068;
        Fri, 27 Dec 2019 19:49:25 -0800 (PST)
Received: from cisco ([2601:282:902:b340:f166:b50c:bba2:408])
        by smtp.gmail.com with ESMTPSA id q22sm9864425iot.39.2019.12.27.19.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 19:49:24 -0800 (PST)
Date:   Fri, 27 Dec 2019 20:49:21 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        jannh@google.com, christian.brauner@ubuntu.com,
        keescook@chromium.org, cyphar@cyphar.com
Subject: Re: [PATCH v2 2/2] seccomp: Check that seccomp_notif is zeroed out
 by the user
Message-ID: <20191228034921.GG15663@cisco>
References: <20191228014849.GA31783@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228014849.GA31783@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Dec 28, 2019 at 01:48:51AM +0000, Sargun Dhillon wrote:
> This patch is a small change in enforcement of the uapi for
> SECCOMP_IOCTL_NOTIF_RECV ioctl. Specifically, the datastructure which
> is passed (seccomp_notif) must be zeroed out. Previously any of its
> members could be set to nonsense values, and we would ignore it.
> 
> This ensures all fields are set to their zero value.
> 
> This relies on the seccomp_notif datastructure to not have
> any unnamed padding, as it is valid to initialize the datastructure
> as:
> 
>   struct seccomp_notif notif = {};
> 
> This only initializes named members to their 0-value [1].
> 
> [1]: https://lore.kernel.org/lkml/20191227023131.klnobtlfgeqcmvbb@yavin.dot.cyphar.com/
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>

Acked-by: Tycho Andersen <tycho@tycho.ws>
