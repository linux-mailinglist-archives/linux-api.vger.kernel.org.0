Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BC31998A8
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2020 16:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbgCaOfQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 31 Mar 2020 10:35:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42654 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbgCaOfQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 31 Mar 2020 10:35:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id 22so10402994pfa.9;
        Tue, 31 Mar 2020 07:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TSPLzvrnJ53vv3T/Bya9rsYLlqwB9kjQQg2KaBIgeo0=;
        b=qgCtSO0R8O9wBzICEumW8dbkN0MkW7zfsK9JspmQEYzexcvYOtx7M2JxUc5L5lGvIA
         8TRzOLH/uC87vKucGSQnKaDmQJ8/fxPMuvmAFbgK8A7+fPF1zafWF20HHhH4C3eC0/s5
         +Di+fjESm1uF2A8ogkhAxfxyTgMw/LKf4n7YhklQkgEYzjfKrdHr6jydHIm8AccTo7n3
         uZpmkD0fKkCctFTMusb0jBNcYxTvKlyttBTp4JteFupFM7Z1rjJ1rhGLpRJ1O6ZEqoM0
         uf1cutO152stutmuA8L5pd7tDyNLMbvvNOBWA/mLlJrEXyNH8cROC3rKSgjsspzLs1HY
         Rryw==
X-Gm-Message-State: ANhLgQ323oxc0tQZcybzgkNj2kcDPs4bQ2FrURcxUhLA2XdpIcrOEy37
        pvvG/47bQJbtssBFadApnB0=
X-Google-Smtp-Source: ADFU+vuuBV7k3mY10/4QzCWXRRq2G6ZnBzLTxqNyH56h6BTUITQbgB5aKGbI992Kpqbks70dIQs6Xw==
X-Received: by 2002:a62:ae06:: with SMTP id q6mr18802906pff.137.1585665315490;
        Tue, 31 Mar 2020 07:35:15 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w127sm12572793pfw.218.2020.03.31.07.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:35:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A806E40277; Tue, 31 Mar 2020 14:35:12 +0000 (UTC)
Date:   Tue, 31 Mar 2020 14:35:12 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 2/3] kernel/sysctl: support handling command line aliases
Message-ID: <20200331143512.GZ11244@42.do-not-panic.com>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330115535.3215-3-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 30, 2020 at 01:55:34PM +0200, Vlastimil Babka wrote:
> We can now handle sysctl parameters on kernel command line, but historically
> some parameters introduced their own command line equivalent, which we don't
> want to remove for compatibility reasons. We can however convert them to the
> generic infrastructure with a table translating the legacy command line
> parameters to their sysctl names, and removing the one-off param handlers.
> 
> This patch adds the support and makes the first conversion to demonstrate it,
> on the (deprecated) numa_zonelist_order parameter.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
