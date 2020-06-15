Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015F01F9934
	for <lists+linux-api@lfdr.de>; Mon, 15 Jun 2020 15:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgFONoP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jun 2020 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbgFONoP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jun 2020 09:44:15 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E346CC061A0E
        for <linux-api@vger.kernel.org>; Mon, 15 Jun 2020 06:44:14 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n5so2491762otj.1
        for <linux-api@vger.kernel.org>; Mon, 15 Jun 2020 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DkKzg92P2Wnmc9kMYYYrw93PtoNbrM8ZnPROxEKKoGY=;
        b=IGw30QmJ+zoGDiIJebtjFFK1H5e+9EUGpw/HlqPgVsV3po4pBBzrd7wL1xOXbZCKlL
         VMJK+1M4hHq4Ujc6lpsMU4FAJZMkdjuyS7+yyTZIN7YhgiPBYStd87+PSepcobYI+WRR
         aFzTk4hsgfulW39A/h9w38hQ1GFGMs8s40EntE/XsOWOTpVB+RlAn6pHfzVn+uecbgKO
         3tSHkXE3g7qTHRtUl0yXv7+RVhKXjDXetd2D8LREamfHmo9J0Fm5zrSpowKFNNipg1Ro
         DFe1l2lZZeOsGq8MCrDQTgK9A8yyUWl3tktSeGzUqSDPcp5LmXeNa8L3Yt85Mlv+yx+a
         8ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DkKzg92P2Wnmc9kMYYYrw93PtoNbrM8ZnPROxEKKoGY=;
        b=KpV61yPLsF03zrHc1l7tzQ6ohBSEMHBfUlVYbrCB2eNvQMviUlBP0wZtLT56B7Gplr
         EndM28dSeGeoxAxmokmIYsB3S47q7pEH3hn5q8/dMQ5j3VTg16b7k1c9YP4EB5MCHuSH
         gcZGE7LRwSUyp3HjhC1rGkbUQRvlvtyJBHFOmVs1OWJ0fy0f/6eCEUKsKgUQg4C3+zXN
         nqICPboFm+9fKi+ddRfjtJqH9zJkrbkQCt8W/HO3I5jnLpwB6PwUenNnpUAcVNbs+nrR
         xLeMZL1qa+CO7zynXfu9+3K+597Ntn/EELAx8a4A3eA4r+fIcSt3IworCxWPh3AF4LQ+
         CHsQ==
X-Gm-Message-State: AOAM531C+xNCUpaJk5XTOUE3hcljM/YAUZvHy/8lNCwsUrP1GVDREofc
        OZ9pN/oXQEgHQ5JMFOvfvALPzceIPeM=
X-Google-Smtp-Source: ABdhPJyAlmEykMTdyfYusdBb3mxs03AQ09kHwYETLJTNl0C6+v5Qud6g/yU6aTwFkXV/gTFa0lZmKw==
X-Received: by 2002:a9d:6b93:: with SMTP id b19mr20597483otq.31.1592228654131;
        Mon, 15 Jun 2020 06:44:14 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:f5b5:cc36:51c:a840])
        by smtp.gmail.com with ESMTPSA id m84sm3132316oif.32.2020.06.15.06.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 06:44:13 -0700 (PDT)
Date:   Mon, 15 Jun 2020 07:44:06 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] seccomp: Add extensibility mechanism to read
 notifications
Message-ID: <20200615134406.GA2893648@cisco>
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

I think we're not supposed to use read for control any more, because
"read is for data".

Tycho
