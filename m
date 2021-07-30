Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8443DB3FA
	for <lists+linux-api@lfdr.de>; Fri, 30 Jul 2021 08:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhG3Gyf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Jul 2021 02:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237616AbhG3Gye (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 30 Jul 2021 02:54:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C18D660F6B;
        Fri, 30 Jul 2021 06:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627628070;
        bh=H46xsNB53TZiknPRtRGR1GJYyTltPyt3+oZZ8wWgtFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvxE0wJjx0O2de0RD9DUzNDnUbqXMKXxd6O/HZZdF16hyn2HaKNDNxqGrqOrXu3zW
         a9NyNhD6eUtM0EX0asQJzL8lxTpYaTnl5Z/QLbKIqsE89jfWHK33x65fHTiM1Y8BS1
         SI9/mlN5WwS37HMlicF29zh6JktJ7b+4BevxFsvQ=
Date:   Fri, 30 Jul 2021 08:54:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Zi-cheng <wzc@smail.nju.edu.cn>
Cc:     linux-api@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] corrent sys_reboot annotation
Message-ID: <YQOiI/rxCBSxkdW2@kroah.com>
References: <20210730064032.101113-1-wzc@smail.nju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730064032.101113-1-wzc@smail.nju.edu.cn>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 30, 2021 at 02:40:32PM +0800, Wang Zi-cheng wrote:
> Signed-off-by: Wang Zi-cheng <wzc@smail.nju.edu.cn>

You forgot a changelog text :(
