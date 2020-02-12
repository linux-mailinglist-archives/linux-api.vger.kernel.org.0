Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D39315B449
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 00:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgBLXBa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 18:01:30 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44248 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbgBLXB3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 18:01:29 -0500
Received: by mail-qt1-f194.google.com with SMTP id k7so2956167qth.11;
        Wed, 12 Feb 2020 15:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JcBz18PbzZYVHWwEFTSmvfhhBhEOyk01/pzZwuqpias=;
        b=C08D8zJvnxcF6THx/Xy4j4IHVRV0ZEIEnD2cKDTN9+Pwe7/Sf3uPuJFFoXtekZluOw
         tIiV8LowyEHjUlfaG3l6YX5hP9dZfpx83cyi2b8h0kPK1NgiWZnFGU3h+26COK8hOXdk
         rbOPwcSKm8wPdadHKuNz2PnkuRF7Oo7QMvVqPSogyhqBCjkMFV2Q92QIZQggR4XXa3AH
         PQI6GBqtHUVvtmjNp05Akr6oPjTg5R1oaqNZWu5x7vqufCRJ8scIERiyK12jDHtZTz5T
         ZIC1xaljOkdnYqEO2XOKfLPmapPpy3aR8ZVbFWHCUdDv25MWLirNyBY+fsUqok+Pn/3X
         vQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JcBz18PbzZYVHWwEFTSmvfhhBhEOyk01/pzZwuqpias=;
        b=bjiKcJi51Qytw0GLmTvbEre30q3sa3sJdn52k4qBOiBihNth+05CQnM9qtV1B+h6wT
         50oZYnn1xDXYjIu9ApwkDA4hSLdkSyt53u+KXsqysStjJh3703YqNdjbDEQWxF1K3wxD
         KFy1OlU/WL3rsQ/nylx1omA+vivJs5/lthcPb0UK9vGLprOfYKUASBh/cH/bDgvCN+vd
         cD9bWKTKFAY+OwndwgbpY+3kYYyy4IXNiHVfmJs0c7vJa6yL4S781/ovDad6QTnrRgrO
         e+ZPgavqz9H5+tB0y5B48QHWtqVY+dlkj5Zsxim1ZpT592LEILIdnYikXO9MPGIlGXfS
         LYDg==
X-Gm-Message-State: APjAAAXw15zfX9Y1l7oqzaqDPArcpjJ2WiztEcDoCV8FpDtW7+v5dYXh
        WpJzk5s9nNtnaWgxm1MUmmY=
X-Google-Smtp-Source: APXvYqxUBrwYNknj5zpmevGUVW3jASjeHfY3u+ieBhdpk2U/351Efexdj4WPrdQZz3irqQ8mK5/I2w==
X-Received: by 2002:ac8:7765:: with SMTP id h5mr9318296qtu.223.1581548488699;
        Wed, 12 Feb 2020 15:01:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id c45sm389679qtd.43.2020.02.12.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:01:28 -0800 (PST)
Date:   Wed, 12 Feb 2020 18:01:27 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 0/6] clone3 & cgroups: allow spawning processes into
 cgroups
Message-ID: <20200212230127.GA88887@mtj.thefacebook.com>
References: <20200205132623.670015-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205132623.670015-1-christian.brauner@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 05, 2020 at 02:26:17PM +0100, Christian Brauner wrote:
> Hey Tejun,
> 
> This is v6 of the promised series to enable spawning processes into a
> target cgroup different from the parent's cgroup.

Applied 1-6 to cgroup/for-5.7. There was a conflict with 0cd9d33ace33
("cgroup: init_tasks shouldn't be linked to the root cgroup") which
got fixed up while applying. I'd really appreciate if you can take a
look to see everything is ok.

Thanks a lot for working on this. This is really great.

-- 
tejun
