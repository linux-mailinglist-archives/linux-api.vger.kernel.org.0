Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4D818D70F
	for <lists+linux-api@lfdr.de>; Fri, 20 Mar 2020 19:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCTSd7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Mar 2020 14:33:59 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33041 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgCTSd7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Mar 2020 14:33:59 -0400
Received: by mail-pj1-f68.google.com with SMTP id dw20so3720952pjb.0;
        Fri, 20 Mar 2020 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S7Fui894R9lUu2xo1vf09TLmig4naq9sdfWsRqwPmJ0=;
        b=hu21JmRQA0gv0PwiesOLkjyJGbNmheJ8OF1ARDPC13kWSznREiboKE/qbGYpwIQpSB
         IJodTlinDcyiAkUbd4IrTokwyNJefZHgPEWSnFHPUqXHLWXJyRlQ/QTcCQjbxzn+DKZl
         EITX/zvsIQyKis61huEbg86FiK7+FReoTKsTnpx4yKQ7nCb9Vawe3DTHA2lecbteAhm0
         0S5UwBXX6GE6/aGkL41/8jVH2oGpWaFmxxQh6zAuc66jeuibyN+tua3muXEYo2JuECzO
         mWnqlDc3lqDE/3hV6ctM/dE5sD1IoXyc5y8ujhqT2LCX17C8oq7gQHRuRRNskPahirY3
         GOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S7Fui894R9lUu2xo1vf09TLmig4naq9sdfWsRqwPmJ0=;
        b=Qd4qnCqtJ3aC76jb2QU0XAL1PLdRTfrOIGLSMykMSiMsVCc2hBXlYPrBxPwZDuEsAM
         vwjkZfNoL7pcJL9FnBWZ4C6acV8sHtYaN5qhXfN/nvOQNLQJpSiELwCzbbiKEQyx7OqI
         iozDFmp6O7Fr9Uy8P5YUmcTuJI2jSWZ0VO9eOyJnUsRzO13NwGawFH4TCUfKgrocOek7
         RJKrMmKdphKB/TObEUqJVT7FKrzga2VbPqIf0SiPk1PzjkzMcL0vAqv3Xazko2ImaTwU
         fyKc8C70tjiFTSR41SLt5cKjtxBiPdbWiXGGUulkjTGU8KoqWruV43p33xZa/h66Hzj3
         XbHw==
X-Gm-Message-State: ANhLgQ3Gu8ARQZd5m9ZOXQimMkqCl0CRTMR+qFzUtjGZ/3VtaFQW3aqU
        C5omZmy1HW9PbAwS+ohDk48=
X-Google-Smtp-Source: ADFU+vvUspVXpPWj0jZAAuPx+ygVkmstUOzsVMpCR7zHEhcpsHtwhIEN8zcuSygrsCJPw3ysito5tA==
X-Received: by 2002:a17:90a:da01:: with SMTP id e1mr11297095pjv.100.1584729237878;
        Fri, 20 Mar 2020 11:33:57 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id h11sm6359312pfn.103.2020.03.20.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:33:57 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:33:55 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: clone3: allow creation of time namespace with offset
Message-ID: <20200320183355.GA118769@gmail.com>
References: <20200317083043.226593-1-areber@redhat.com>
 <CAK8P3a2-qQhpRdF0+iVrpp=vEvgwtndQL89CUm_QzoW2QYX1Jw@mail.gmail.com>
 <20200319081137.GC223854@dcbz.redhat.com>
 <CAK8P3a18YySozk6P77JpS58Hbtz=QQmLKw+PrzXbdOwtOQQuJA@mail.gmail.com>
 <20200319102955.i7slokibkkysz6g6@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200319102955.i7slokibkkysz6g6@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 19, 2020 at 11:29:55AM +0100, Christian Brauner wrote:
> On Thu, Mar 19, 2020 at 09:16:43AM +0100, Arnd Bergmann wrote:
> > On Thu, Mar 19, 2020 at 9:11 AM Adrian Reber <areber@redhat.com> wrote:
> > 
> > > With Arnd's idea of only using nanoseconds, timens_offset would then
> > > contain something like this:
> > >
> > > struct timens_offset {
> > >         __aligned_s64 monotonic_offset_ns;
> > >         __aligned_s64 boottime_offset_ns;
> > > };
> > >
> > > I kind of prefer adding boottime and monotonic directly to struct clone_args
> > >
> > >         __aligned_u64 tls;
> > >         __aligned_u64 set_tid;
> > >         __aligned_u64 set_tid_size;
> > > +       __aligned_s64 monotonic_offset_ns;
> > > +       __aligned_s64 boottime_offset_ns;
> > >  };
> > 
> > I would also prefer the second approach using two 64-bit integers
> > instead of a pointer, as it keeps the interface simpler to implement
> > and simpler to interpret by other tools.
> 
> Why I don't like has two reasons. There's the scenario where we have
> added new extensions after the new boottime member and then we introduce
> another offset. Then you'd be looking at:
> 
> __aligned_u64 tls;
> __aligned_u64 set_tid;
> __aligned_u64 set_tid_size;
> + __aligned_s64 monotonic_offset_ns;
> + __aligned_s64 boottime_offset_ns;
> __aligned_s64 something_1
> __aligned_s64 anything_2
> + __aligned_s64 sometime_offset_ns
> 
> which bothers me just by looking at it. That's in addition to adding two
> new members to the struct when most people will never set CLONE_NEWTIME.
> We'll also likely have more features in the future that will want to
> pass down more info than we want to directly expose in struct
> clone_args, e.g. for a long time I have been thinking about adding a
> struct for CLONE_NEWUSER that allows you to specify the id mappings you
> want the new user namespace to get. We surely don't want to force all
> new info into the uppermost struct. So I'm not convinced we should here.

I think here we can start thinking about a netlink-like interface.

struct clone_args {
	....
	u64	attrs_offset;
}

struct clone_attr {
	u16 cla_len;
	u16 cla_type;
}


....

int parse_clone_attributes(struct kernel_clone_args *kargs, struct clone_args *args, size_t args_size)
{
	u64 off = args->attrs_offset;

	while (off < size) {
		struct clone_attr *attr;

		if (off + sizeof(struct clone_attr) uargs_size)
			return -EINVAL;

		attr = (struct clone_attr *) ((void *)args + off);

		if (attr->cla_type > CLONE_ATTR_TYPE_MAX)
			return -ENOSYS;

		kargs->attrs[attr->cla_type] = CLONE_ATTR_DATA(attr);
		off += CLONE_ATTR_LEN(attr);
	}

	return 0;
}

This interface doesn't suffer from problems what you enumerated before:

* clone_args contains only fields which are often used.
* per-feature attributes can be extended in a future without breaking
  backward compatibility.
* unused features don't affect clone3 argument size.
* seccomp-friendly (I am not 100% sure about this)

